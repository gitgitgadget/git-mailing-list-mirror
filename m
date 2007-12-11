From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH (amend)] diff: Make numstat machine friendly also for renames (and copies)
Date: Wed, 12 Dec 2007 00:09:35 +0100
Message-ID: <200712120009.36560.jnareb@gmail.com>
References: <200712102332.53114.jnareb@gmail.com> <200712110226.35343.jnareb@gmail.com> <7vprxehrlv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 00:10:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2EEq-0000Js-3A
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 00:10:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753517AbXLKXJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 18:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753906AbXLKXJq
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 18:09:46 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:35515 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753034AbXLKXJp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 18:09:45 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1404514nfb
        for <git@vger.kernel.org>; Tue, 11 Dec 2007 15:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=x1ZVoX+Oh0XuDDl0n1f8j+uflxZtEnJ0U42czrlza3A=;
        b=JGsVdvD6AEE4V40n9Lg+sNrxK59TdXJdZUgVUYeRaT9txibhgI8fEZe8EuRVlT3W+f2NYKBkO7gfmN3UXobCEgvQ6DsV2J+FIIdnDSzhrSg3nT5pq0L3qjY5u+IxhyzvZeopJzDB/3NOZALJ53bKkXmwyrbGRuw7VNorCERXIFs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=wLXXBAmBoN6YM8ioTNDjW24I6WemP4GYJhMFQzDMUU7cYv+8hHCHmkCv09qLylMo8kIheh0JC6NGAd7GVOvP+bTOGPVCgBoIM7WB9VoWjoec9CgiS5wVHVrf8EuLZBocyS2b9EMs2IU7cnnVfpVahVHRyg3WxNGK2aoE7YdLb0A=
Received: by 10.86.100.7 with SMTP id x7mr7228628fgb.1197414582956;
        Tue, 11 Dec 2007 15:09:42 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.252.236])
        by mx.google.com with ESMTPS id e20sm6251172fga.2007.12.11.15.09.40
        (version=SSLv3 cipher=OTHER);
        Tue, 11 Dec 2007 15:09:41 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vprxehrlv.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67965>

On Wed, 11 Dec 2007, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> Junio C Hamano wrote:
>>> Jakub Narebski <jnareb@gmail.com> writes:
>>> 
>>>> Previous version of this patch (from 7 May 2007) used instead of current
>>>> only "to_name" format similar to git-diff-tree raw format for renames:
>>>>
>>>>   added deleted TAB path for "src" TAB path for "dst" LF
> 
> That's perfectly fine (that is without -z).
> 
>>>> ... Previous version
>>>> of patch used (or was to use actually, because of error in the code)
>>>>
>>>>   added deleted TAB path for "src" NUL NUL path for "dst" NUL
>>>>
>>>> when -z option was used.
> 
> I think your "previous" one:
> 
> 	<added> <deleted> <src> NUL		  (no rename)
> 	<added> <deleted> <src> NUL NUL <dst> NUL (with rename)
> 
> would be unambiguously parsable, but it would be cleaner and easier for
> the parser if the latter were like this instead:
> 
> 	<added> <deleted> NUL <src> NUL <dst> NUL (with rename)
> 
> The reader can expect to find a NUL terminated src, finds the length is
> zero and notices it cannot be src and then reads two paths from that
> point.

Very good idea.

> Without having the status letter, we cannot do "optional two paths"
> without breaking existing --numstat -z readers that do not care about
> renames and copies, and I agree that existing --numstat -z readers that
> pass -M or -C are already broken, so I think a format extension along
> the above line (your "previous" and the above clean-up proposal have the
> same power of expressiveness, I just think the latter is syntactically
> cleaner) would be reasonable.  And at that point we probably would not
> need --numstat-enhanced at all ;-)

The previous patch is a fix (usability fix) for numstat output in the
presence of rename detection, making it truly machine friendly. Moreover
it should not break any scripts which parsed numstat output not
expecting to deal with renames (for example if repository has
diff.renames config option set), and might even fix them.

The proposed - and implemented in patch below - change could break some
scripts not expecting to deal with new numstat output. Adding status
letter (with similarity/dissimilarity percentage info) would
unfortunately require greater surgery... We can either allow scripts
(do there exist any?) to break, or make the full rename info shown
only for --numstat-extended; but I'd like to have this status letter
for --numstat-extended / --numstat-enhanced.

So possible solution are:
 (a) Accept both patches, and accept remote possibility that some
     scripts might break
 (b) Add --numstat-extended option whoich would show rename info
     as implemented in this patch (and of course accept previous)
 (c) Implement --numstat-extended with status letter, as suggested,
     accept first patch but not this one.


Note that gitweb would require --numstat with proper rename detection
support if we want to e.g. provide graphical diffstat in 'commit' view
for merge commits.


P.S. The numstat output format for renames should be probably described
in documentation, and not only in commit message, but I was not sure
where to put it (and even how it should be written).

-- >8 --
From: Jakub Narebski <jnareb@gmail.com>
Date: Tue, 11 Dec 2007 23:52:18 +0100
Subject: [RFC/PATCH] diff: Show rename info in numstat output, correctly

Make numstat output of git-diff show both source and destination
filename for renames (and copies) in easily parseable format, similar
to raw diff output format.

The numstat format for rename (or copy) is now

  <added> <deleted> TAB <path for "src"> TAB <path for "dst"> LF

or if -z option is used

  <added> <deleted> TAB NULL <path for "src"> NULL <path for "dst"> NULL

where <added> and <deleted> is number of added/deleted lines
(or '-' for binary file).

When -z option is not used, TAB, LF, and backslash characters in
pathnames are represented as \t, \n, and \\, respectively.


Idea for -z numstat rename format by Junio C Hamano.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 diff.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index 8039ac7..56cbf28 100644
--- a/diff.c
+++ b/diff.c
@@ -991,7 +991,14 @@ static void show_numstat(struct diffstat_t* data, struct diff_options *options)
 			printf("-\t-\t");
 		else
 			printf("%d\t%d\t", file->added, file->deleted);
-		write_name_quoted(file->name, stdout, options->line_termination);
+		if (file->is_renamed) {
+			char sep = options->line_termination ? '\t' : '\0';
+			if (!options->line_termination)
+				putchar(options->line_termination);
+			write_name_quoted(file->from_name, stdout, sep);
+			write_name_quoted(file->name, stdout, options->line_termination);
+		} else
+			write_name_quoted(file->name, stdout, options->line_termination);
 	}
 }
 
-- 
1.5.3.7
