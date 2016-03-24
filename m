From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-apply does not work in a sub-directory of a Git repository
Date: Thu, 24 Mar 2016 10:32:35 -0700
Message-ID: <xmqqtwjv93yk.fsf@gitster.mtv.corp.google.com>
References: <CACsJy8CTix-ZwN04MwYTB+JEtDCV27QVf7_0vWmhUSVCwU29Jg@mail.gmail.com>
	<1458820579-31621-1-git-send-email-pclouds@gmail.com>
	<xmqq8u17akgn.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sbeller@google.com, mehul.jain2029@gmail.com,
	sandals@crustytoothpaste.net
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 18:32:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj97j-0000IS-9K
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 18:32:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbcCXRci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 13:32:38 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:53618 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750736AbcCXRci (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 13:32:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0F6C34C9C6;
	Thu, 24 Mar 2016 13:32:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d1Rl0iBYLTyG0DNj3y+9gkWJ68k=; b=VIVS5G
	tj1WZugx0Qb5ZCNHLJfv9J5kWuon7FSyRI325EhaOZeNyOqurHgNP/1BX3C5hyzJ
	NtLIMV8DKOeqgW4egUzCB0KHDxBlFLtbsgSZxslw3nt496TsACI2i2CThKUfYlU1
	usLCagbWTdqfFlXLDSz/b1tTsHBAKcCloI+X0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xPnye2jYCltP2p5HnPCvgxe0f/kTUJr9
	v91R3bJa3aXyNXVdU/CGVgFTvH5znmusZ6ZZFLEz69B+z6aBDhEz1rsfBMHuFR1h
	97TvN3wWDYXbcS+tm9Nu80qrBxvhWqYVs91V2HrV2j1CEo1ZABJHUwAyuFVvuOzG
	AZAOIs34m3I=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 05FE04C9C5;
	Thu, 24 Mar 2016 13:32:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 787994C9C4;
	Thu, 24 Mar 2016 13:32:36 -0400 (EDT)
In-Reply-To: <xmqq8u17akgn.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 24 Mar 2016 09:50:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 664320C6-F1E6-11E5-A0F5-EB7E6AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289767>

Junio C Hamano <gitster@pobox.com> writes:

> So a better alternative may be to conditionally disable the "Paths
> outside are not touched regardless of --include" logic, i.e. we
> exclude paths outside by default just as before, but if there is at
> least one explicit "--include" given, we skip this "return 0".
>
> That way, we do not have to commit to turning --include/--exclude to
> pathspec (which I agree is a huge change in behaviour that may not
> be a good idea) and we do not have to add "--full-tree" that is only
> understood by "apply" but not other commands that operate on the
> current directory by default.

And the necessary change to do so may look like this.  With this:

    $ git show >P
    $ git reset --hard HEAD^
    $ cd t
    $ git apply -v ../P
    $ git apply -v --include=\* ../P

seem to work as expected.

diff --git a/builtin/apply.c b/builtin/apply.c
index c993333..1af3f7e 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1955,8 +1955,8 @@ static int use_patch(struct patch *p)
 	const char *pathname = p->new_name ? p->new_name : p->old_name;
 	int i;
 
-	/* Paths outside are not touched regardless of "--include" */
-	if (0 < prefix_length) {
+	/* Paths outside are not touched when there is no explicit "--include" */
+	if (!has_include && 0 < prefix_length) {
 		int pathlen = strlen(pathname);
 		if (pathlen <= prefix_length ||
 		    memcmp(prefix, pathname, prefix_length))
