From: Timothy Chen <tnachen@gmail.com>
Subject: Re: [PATCH] Allow multiple merges to invalid HEAD
Date: Mon, 4 Apr 2011 23:01:53 -0700
Message-ID: <ABB52AD0-EAF4-43CA-951D-9ED8A5FB1929@gmail.com>
References: <1301813216-19507-1-git-send-email-tnachen@gmail.com> <20110403222234.GB6537@elie>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 05 08:02:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6zLA-0005fx-As
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 08:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288Ab1DEGCG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 02:02:06 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51228 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906Ab1DEGCE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Apr 2011 02:02:04 -0400
Received: by iyb14 with SMTP id 14so44977iyb.19
        for <git@vger.kernel.org>; Mon, 04 Apr 2011 23:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:content-type:mime-version:subject:from
         :in-reply-to:date:content-transfer-encoding:message-id:references:to
         :x-mailer;
        bh=imZsxozOWfj+wTUne/7dZXGu2+B03RNt/DwkiPiyFB8=;
        b=eoI0xBlpZPz3JON9yeWc+VVywNFmwCiwWNRXkMSuakhgtl08O3zCuVraZq4z7slRWg
         TmjFD0fG3sCqFnuyg6DRYyUEwLVs9iPMgaFz4AL7bP5oTJ/77g8EbOlv78R3cctitHXe
         Iy17Z4vckE2WJshXjvhW5LdCQtv7aC+V3QgeE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=content-type:mime-version:subject:from:in-reply-to:date
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=bDmrxmNn89H8SM0hJbEv+nKgnuuOh22RkmJFpU22Mzi/XIDext3YYNwQvyafos6bVr
         W45RgVbu3PFQrKBQx0uW9XBH4Oqgwnu23R2uvbrCKpSJRL3C2SmMLLxbMpzk99HbPwpY
         U2omfwV2WEuxj12L6k2inAAzYed30zGTez0rU=
Received: by 10.42.149.132 with SMTP id w4mr12264227icv.267.1301983322343;
        Mon, 04 Apr 2011 23:02:02 -0700 (PDT)
Received: from [192.168.1.100] (c-24-19-190-111.hsd1.wa.comcast.net [24.19.190.111])
        by mx.google.com with ESMTPS id c1sm395398ibe.0.2011.04.04.23.01.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 04 Apr 2011 23:01:57 -0700 (PDT)
In-Reply-To: <20110403222234.GB6537@elie>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170868>

Thanks for all the review.

Yes I agree it does brings more complexity with a small gain in feature.

So please disregard this patch (also please forgive my missing signed-off as it's my first patch), as I'm gonna move on to work on some fixes on submodules as I originally intended.

Thanks!

Tim

On Apr 3, 2011, at 3:22 PM, Jonathan Nieder wrote:

> Hi,
> 
> Timothy Chen wrote:
> 
>> builtin/merge.c |   57 +++++++++++++++++++++++++++++-------------------------
>> 1 files changed, 31 insertions(+), 26 deletions(-)
> 
> Now for mechanics.
> 
>> --- a/builtin/merge.c
>> +++ b/builtin/merge.c
> [...]
>> @@ -1101,36 +1098,44 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>> 		remote_head = peel_to_type(argv[0], 0, NULL, OBJ_COMMIT);
>> 		if (!remote_head)
>> 			die(_("%s - not something we can merge"), argv[0]);
>> -		read_empty(remote_head->sha1, 0);
>> 		update_ref("initial pull", "HEAD", remote_head->sha1, NULL, 0,
>> 				DIE_ON_ERR);
>> -		return 0;
>> +
>> +		if (argc < 2)
>> +			return 0;
> 
> When argc == 1, this means read_empty never gets called.  Is that
> intended?
> 
> It breaks 7607.13.  Running "make test" is a good way to find some
> breakages.
> 
>> +
>> +		hashcpy(head, remote_head->sha1);
>> +		read_empty(remote_head->sha1, 0);
>> +		head_arg = argv[0];
>> +		argc--;
>> +		argv++;
> 
> As always when pretending something, I think a comment would be
> helpful.  Something to the effect of:
> 
> 	/*
> 	 * We were called as "git merge <branch1> <branch2> <branch3>...".
> 	 *
> 	 * Now HEAD has advanced to <branch1>, and we can pretend
> 	 * we were called as "git merge <branch2> <branch3>...".
> 	 */
> 
> Though I think I prefer the more explicit comment I suggested last
> time[1].
> 
>> +	}
>> +
>> +	struct strbuf merge_names = STRBUF_INIT;
>> +
>> -	} else {
>> -		struct strbuf merge_names = STRBUF_INIT;
>> -
>> -		/* We are invoked directly as the first-class UI. */
>> +	/* We are invoked directly as the first-class UI. */
> 
> Won't this break
> 
> 	git merge "message here" $(git rev-parse HEAD) foo bar
> 
> ?  Previously this code was in an "else" block so it wasn't reached in
> the is_old_style_invocation case.
> 
>> -	if (head_invalid || !argc)
>> +	if (!argc)
>> 		usage_with_options(builtin_merge_usage,
>> 			builtin_merge_options);
> 
> What happens with
> 
> 	git merge "message here" HEAD foo bar
> 
> from an unborn branch?
> 
> Hope that helps.
> Jonathan
> 
> [1] http://thread.gmane.org/gmane.comp.version-control.git/170456
