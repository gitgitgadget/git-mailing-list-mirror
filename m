From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] git-completion.bash: add support for path completion
Date: Fri, 04 Jan 2013 22:27:10 -0800
Message-ID: <7vehi0qh4x.fsf@alter.siamese.dyndns.org>
References: <1356108872-5881-1-git-send-email-manlio.perillo@gmail.com>
 <E59706EF8DB1D147B15BECA3322E4BDC0672D1@eusaamb103.ericsson.se>
 <7vobh4sffw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, szeder@ira.uka.de, felipe.contreras@gmail.com
To: Marc Khouzam <marc.khouzam@ericsson.com>,
	Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 07:27:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrNED-0002kc-Il
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 07:27:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753924Ab3AEG1P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 01:27:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43690 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753136Ab3AEG1N (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 01:27:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E91B5828E;
	Sat,  5 Jan 2013 01:27:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=52ffuM3D7/T5UDzYeEZVsXUV3pA=; b=DQqBrt
	K7OFnysHAjtUyFPwicYgzinh4zExuaryXIRzfhfv6YRLHmNQyi+MkehhZ951mkYK
	GBbu22H+OgeWeWx/TTboisACKIUhr7K4FKPcLMxxqdtS6Rb2R3tZleb40/r/zx9E
	Q0pot+wZGLq2eUFO89h4wMs3edt91v6xOJ0+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FPB3ki6wTFHwc3g3ucJFDKKD7wP2hbSP
	iztJn4SXaxvwhWjMFtQOJ4uJtI6HnlQ3Z5NhVQeCXrGJsqHgGl3vHuHRv4zkkLsv
	gAaJp055Z9IZJXqaJzIYMxZKpK/K0Qx0mYZrkkxXb0Q9qfginfF4o8hEOKHSbmxY
	mWVVNIXELHw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA0E4828D;
	Sat,  5 Jan 2013 01:27:12 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1810E828C; Sat,  5 Jan 2013
 01:27:11 -0500 (EST)
In-Reply-To: <7vobh4sffw.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 04 Jan 2013 15:20:51 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F07FED84-5700-11E2-AE4F-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212664>

Junio C Hamano <gitster@pobox.com> writes:

> Marc Khouzam <marc.khouzam@ericsson.com> writes:
>
>> I've been playing with it but I'm not getting the expected 
>> behavior when I cd to a sub-directory.
>
> Thanks for testing.  Manlio?

Can you try the attached patch?

As I am not familiar with the completion machinery, take this with a
large grain of salt.  Here is my explanation of what is going on in
this "how about this" fixup:

 * Giving --git-dir from the command line (or GIT_DIR environment)
   without specifying GIT_WORK_TREE is to signal Git that you are at
   the top of the working tree.  "git ls-files" will then show the
   full tree even outside the real $cwd because you are lying to
   Git.

 * "git diff-index" could be told to show only the $cwd and its
   subdirectory with the "--relative" option, but it alone is not
   sufficient if you throw --git-dir at it; again, you end up lying
   that you are at the top.

 * As far as I can tell, there is no reason you would want to pass
   "--git-dir" to these invocations of ls-files and diff-index.  If
   the previous call to "__gitdir" could figure out where it is, the
   command should be able to figure it out the same way.
   
There seem to be millions of other existing "git --git-dir=$there"
in this script.  As I already said, I am not familiar with the
completion machinery, and I do not know what they are for in the
first place.  Perhaps people put them there for a reason, but I do
not know what that reason is.

I think the ones for "for-each-ref", "config" and "stash" should be
harmless.  They are commands that do not care about the working
tree.

There is one given to "ls-tree" used in __git_complete_revlist_file;
I do not know if this was intended, what it is for, and if that is
working as intended, though.

I've been CC'ing two people who touched this script rather heavily,
are expected to know the completion machinery, and should be able to
help polishing this topic and moving it forward.  Perhaps one of
them can shed light on this.

-- >8 --
Subject: completion: do not pass harmful "--git-dir=$there"

The recently added __git_index_files and __git_diff_index_files
helper functions invoke "ls-files" and "diff_index" while explicitly
passing "--git-dir=$there", to tell them that the invocation is done
at the top of the working tree, which may not be the case when the
user is in a subdirectory.  Remove the harmful use of this option,

Tell "diff-index" to show only the paths in the $cwd and show them
relative to the $cwd by passing "--relative". The "ls-files" does
not need this, as that is already its default mode of operation.

---
 contrib/completion/git-completion.bash | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c8c6464..f4bd548 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -267,9 +267,9 @@ __git_index_files ()
 
 	if [ -d "$dir" ]; then
 		# NOTE: $1 is not quoted in order to support multiple options
-		git --git-dir="$dir" ls-files --exclude-standard $1 ${2+"$2"} 2>/dev/null |
-			__git_index_file_list_filter ${2+"$2"} |
-			uniq
+		git ls-files --exclude-standard $1 ${2+"$2"} 2>/dev/null |
+		__git_index_file_list_filter ${2+"$2"} |
+		uniq
 	fi
 }
 
@@ -284,9 +284,9 @@ __git_diff_index_files ()
 	local dir="$(__gitdir)"
 
 	if [ -d "$dir" ]; then
-		git --git-dir="$dir" diff-index --name-only "$1" 2>/dev/null |
-			__git_index_file_list_filter ${2+"$2"} |
-			uniq
+		git diff-index --name-only --relative "$1" 2>/dev/null |
+		__git_index_file_list_filter ${2+"$2"} |
+		uniq
 	fi
 }
 
