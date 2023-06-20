Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BD3EB64DC
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 18:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjFTSbx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 14:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjFTSbt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 14:31:49 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA0A1984
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 11:31:33 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B0F0B2A5E9;
        Tue, 20 Jun 2023 14:31:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MFa5BbRduFSLmUV6outxkZB5AjXnRODzdf2Xy1
        udS9s=; b=l9uuLPseCiXLGQM0XaI6hyr5jeBJhFLAY00IOmlpTWoyqyyK6Thwo9
        V5OD5JfZYqTt91olHG9SOuj8iTj0ZWO+HnTPih5Q1HiRlOQNNMxjT+EatdmANXu1
        Q5VRRtI9XyhmyAvWOR8Pe7yc7uE+jugNWwLRBp3wzlKF5kcdqZn4o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A99BD2A5E8;
        Tue, 20 Jun 2023 14:31:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C4D502A5E7;
        Tue, 20 Jun 2023 14:31:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tao Klerks <tao@klerks.biz>
Cc:     git <git@vger.kernel.org>
Subject: Re: Determining whether you have a commit locally, in a partial clone?
References: <CAPMMpohiTzANyhzL-mS-gg2kzbOEOiDktNbdwEXBKy9uL0-JgA@mail.gmail.com>
        <CAPMMpog8Hv_KcjNxbh_wzjwrFYt7TuTvrVy1XEtJMm6RWSKzRg@mail.gmail.com>
Date:   Tue, 20 Jun 2023 11:31:01 -0700
In-Reply-To: <CAPMMpog8Hv_KcjNxbh_wzjwrFYt7TuTvrVy1XEtJMm6RWSKzRg@mail.gmail.com>
        (Tao Klerks's message of "Tue, 20 Jun 2023 14:04:06 +0200")
Message-ID: <xmqqo7lam1ei.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9C620AFA-0F98-11EE-92B5-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tao Klerks <tao@klerks.biz> writes:

> My apologies for the self-reply, I did find a workaround here:
>
> git -c remote.origin.url log SOME_HASH_NOT_IN_REFSPEC
>
> I don't understand what's happening here at all, because setting
> "remote.origin.url" to "True" in this way works to prevent the
> normally configured URL from kicking in, ...

Interesting.  This happens inside remote.c:handle_config() where
git_config_string() is used to reject a non-string value given to
the "remote.<name>.url" variable and abort the process to read from
the configuration file by returning -1 and causes whoever uses that
configuration value to die.  As the command line configuration is
read first, aborting the configuration reader early would mean that
the configured values would not even be read.

I am not sure why this does not cause the entire thing to die,
though.  It requires further digging, for which I do not have time
for right now..

> ... but setting a different value
> (or empty value) does not.

Most likely, this is because you are giving a syntactically correct
value so the usual "last one wins" logic kicks in.

In hindsight, I think (1) the first one should probably fail the
"git log" process (not just the lazy fetch subprocess), and (2)
there should be an explicit way, e.g. giving an empty string, to
"clear" the list of .url accumulated so far.

(2) may look something silly like this:

 remote.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git c/remote.c w/remote.c
index 0764fca0db..ecc146856a 100644
--- c/remote.c
+++ w/remote.c
@@ -64,12 +64,22 @@ static const char *alias_url(const char *url, struct rewrites *r)
 
 static void add_url(struct remote *remote, const char *url)
 {
+	if (!*url) {
+		remote->url_nr = 0;
+		return;
+	}
+
 	ALLOC_GROW(remote->url, remote->url_nr + 1, remote->url_alloc);
 	remote->url[remote->url_nr++] = url;
 }
 
 static void add_pushurl(struct remote *remote, const char *pushurl)
 {
+	if (!*pushurl) {
+		remote->pushurl_nr = 0;
+		return;
+	}
+
 	ALLOC_GROW(remote->pushurl, remote->pushurl_nr + 1, remote->pushurl_alloc);
 	remote->pushurl[remote->pushurl_nr++] = pushurl;
 }

