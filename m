From: Junio C Hamano <gitster@pobox.com>
Subject: Re: grep --no-index and pathspec
Date: Fri, 11 Feb 2011 13:37:10 -0800
Message-ID: <7vwrl6z20p.fsf@alter.siamese.dyndns.org>
References: <20110211095938.360726y1zinab9gk@webmail.df.eu>
 <4D55500B.1070603@drmicha.warpmail.net>
 <7v8vxm1l6q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Lars Noschinski <lars@public.noschinski.de>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Feb 11 22:37:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Po0ga-0006oL-U0
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 22:37:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424Ab1BKVh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Feb 2011 16:37:27 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60075 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932391Ab1BKVhY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Feb 2011 16:37:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EFA7D4232;
	Fri, 11 Feb 2011 16:38:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C1xF0cG0cv+6xbLRXs2/FMFcD2c=; b=SEuLxL
	HQqlqaWtlQZdzq5a/yvL5zpZxQPYEC1hgDbFnfChozziI1Fzbmkt5brnr0KOFudH
	nUGq27Ux2S3F7G84+Y2Q6tfj7SkB7a8L319QGZhZkmBm66tZbtPwyA/XtNXpGNeL
	783c9noPNgpsRL56474O9H48kM9KyDGinlmVo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y7KWypa5JrSCboWQrJqArQ3g7c8iSq3r
	E0sz1fsG3z9DF83+zvS0ioFE5LmS1e5STKw8WKGL6VyVO9mDebWZx+7Ew6P8ILdC
	EWM4bFnoOB3y+c2KclRZ8bCwSye7QfWoWSH5ArxdfGNev9mPyg5mCZWiyVRJKlw9
	7xgqWLFYu8U=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AFAF7422D;
	Fri, 11 Feb 2011 16:38:20 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 52871422B; Fri, 11 Feb 2011
 16:38:15 -0500 (EST)
In-Reply-To: <7v8vxm1l6q.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 11 Feb 2011 10\:27\:09 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3ED38ECA-3627-11E0-AFA7-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166574>

Junio C Hamano <gitster@pobox.com> writes:

> Michael J Gruber <git@drmicha.warpmail.net> writes:
>
>> "grep --no-index" and "grep" have different codepaths for looking up the
>> files/blobs. If I read that correctly then "grep --no-index -- pathspec"
>> only does a literal match at the left boundary, whereas for the normal
>> mode glob patterns are allowed.
>>
>> CC'ing Junio who created "--no-index".
>
> Anything with --no-index is a quick hack, so I wouldn't be surprised if it
> ignored the normal pathspec logic.  As I do not recall the details of the
> particular codepath and offhand do not know how involved a change to pay
> proper attention to the pathspecs would be, but I suspect that it would be
> more appropriate to fix it on top of nd/struct-pathspec topic than writing
> the current behaviour down in the documentation outside of BUGS section as
> if it were a feature ;-).

This is a band-aid modelled after what builtin/clean.c does to the
returned list from fill_directory(), and it seems to do its job, but I am
quite unhappy about it.

The function fill_directory() already takes a pathspec, albeit in the
degenerate "const char **" form.  Why does its output need further
filtering?

 builtin/grep.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index c3af876..5afee2f 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -626,6 +626,10 @@ static int grep_directory(struct grep_opt *opt, const struct pathspec *pathspec)
 
 	fill_directory(&dir, pathspec->raw);
 	for (i = 0; i < dir.nr; i++) {
+		const char *name = dir.entries[i]->name;
+		int namelen = strlen(name);
+		if (!match_pathspec_depth(pathspec, name, namelen, 0, NULL))
+			continue;
 		hit |= grep_file(opt, dir.entries[i]->name);
 		if (hit && opt->status_only)
 			break;
