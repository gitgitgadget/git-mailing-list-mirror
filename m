From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [BUG/RFC] Raw diff output format (git-diff-tree) and --relative[=<path>] option
Date: Thu, 8 Jul 2010 16:56:20 +0200
Message-ID: <201007081656.23474.jnareb@gmail.com>
References: <201007051015.26995.jnareb@gmail.com> <201007081419.42702.jnareb@gmail.com> <20100708142341.GA9991@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 08 16:56:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWsWl-0000r2-8i
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 16:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755512Ab0GHO4d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 10:56:33 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54782 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753870Ab0GHO4d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 10:56:33 -0400
Received: by fxm14 with SMTP id 14so462881fxm.19
        for <git@vger.kernel.org>; Thu, 08 Jul 2010 07:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=jHrtcjYrgjxEidrIduStlAVmRuwXMKJWG1WCMcSJqYw=;
        b=C/SwXGfK0+K7ZA742lI97X//sP/17Tn7MmEbyzN50E0lLa4ez2xX/56nyg46Crslzt
         KhtZ//GrTXmPP1vWP6D3kA9VRAGcD56r3PhPNJtCd368Oo5X4Vh4cr8ZaM+cEGj2jmih
         qw/QZlaJvg7YsuIYDz4IJuKN9HnhzJ1dfvqNM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=N+EOkiRfQf+3wn3XpsFchtHE1Az6CC57yRyGIAcxS8heqk4ZZQFqQ2knd5nRNbyZEn
         sqtViA4Mv4/lpaFrAT5c5WovRhHZv+5hmRjyTtn5hWmlBBD+aF9aiWbL9LkgHhr1VOp9
         WbFAC8h25E8RiKO+cUTntuQxcXaCXLo80jlQs=
Received: by 10.223.113.142 with SMTP id a14mr7225765faq.33.1278600991285;
        Thu, 08 Jul 2010 07:56:31 -0700 (PDT)
Received: from [192.168.1.15] (abvu212.neoplus.adsl.tpnet.pl [83.8.218.212])
        by mx.google.com with ESMTPS id 16sm17124420far.40.2010.07.08.07.56.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Jul 2010 07:56:30 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20100708142341.GA9991@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150581>

On Thu, 8 Jul 2010, Jeff King wrote:
> On Thu, Jul 08, 2010 at 02:19:42PM +0200, Jakub Narebski wrote:
> 
> > Nevertheless for the patch output format both "git diff --relative=sub"
> > and "git diff --relative=sub/" give the same output, without 'b//quux'.
> > The same IMHO should be done for raw output format, so we don't have
> > '/quux' but 'quux'.
> 
> Hmm. That is because the diff output properly eliminates the double "/".
> But AFAICT, all of the following do what I would expect:
> 
>   git diff --relative=sub
>   git diff --relative=sub/ ;# same as above
>   git diff --relative=foo- ;# yields "a/10" for file "foo-10"
> 
> Doing
> 
>   git diff --relative=sub --stat
> 
> shows the same issue as your --raw version, as does --name-only. I think
> the right solution is to clean up a leading "/" for those cases. That
> leaves the possibility for non-directory prefixes, but should do what
> the user wants in the directory case (since a leading "/" is
> nonsensical).

Perhaps this would be enough:

-- >8 --
diff --git i/diff.c w/diff.c
index 3aa695d..3a4696e 100644
--- i/diff.c
+++ w/diff.c
@@ -2705,10 +2705,16 @@ static void diff_fill_sha1_info(struct diff_filespec *one)
 static void strip_prefix(int prefix_length, const char **namep, const char **otherp)
 {
 	/* Strip the prefix but do not molest /dev/null and absolute paths */
-	if (*namep && **namep != '/')
+	if (*namep && **namep != '/') {
 		*namep += prefix_length;
-	if (*otherp && **otherp != '/')
+		if (**namep == '/')
+			++*namep;
+	}
+	if (*otherp && **otherp != '/') {
 		*otherp += prefix_length;
+		if (**otherp == '/')
+			++*otherp;
+	}
 }
 
 static void run_diff(struct diff_filepair *p, struct diff_options *o)
-- 8< --

> 
> Or was that what you had in mind the whole time? My impression was that
> you wanted --relative=foo to always be equivalent to --relative=foo/.
> The subtle difference is that I want the "/" removed only if it is the
> next character (or another way of thinking about it is to append "/" to
> the prefix only if it is an actual directory).

What I wanted is for "git diff-tree A B --relative=sub" to behave as
"git diff-tree A:sub B:sub".  Currently without -r / -t (without turning
on recursive mode) it produces no output; well at least no output if
'sub' is really subdirectory.

What's more I wanted for "git diff --raw" in any combination to behave
the same... although I guess here point is moot, as "git diff" is
automatically recursive regardless of output format, and you can't turn
it off.

Stil I'd like for "git diff-tree <commit>" to behave appropriately
with --relative or --relative=<path>.

-- 
Jakub Narebski
Poland
