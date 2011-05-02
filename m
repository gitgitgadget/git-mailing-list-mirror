From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Annoyance] "git log .." thinks ".." is ambiguous
Date: Mon, 02 May 2011 13:36:24 -0700
Message-ID: <7vhb9clu0n.fsf@alter.siamese.dyndns.org>
References: <7vr58glxro.fsf@alter.siamese.dyndns.org>
 <20110502193321.GB10487@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 02 22:36:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGzrE-0006s4-D1
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 22:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756232Ab1EBUgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 16:36:35 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65038 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753616Ab1EBUge (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 16:36:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7C61A4C90;
	Mon,  2 May 2011 16:38:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pgHT7GNgcrWgalaO4B0MHOmJKI0=; b=w7Kt1Q
	sCJvoQ/hImuPPm9gVNv5KNt0gAJMrtF7nB6ZrDUF8JsD54RfSdLmOfrPxAnMBgiG
	iajHcPt7UecttUhlDfQ2V5uIuJP9iw5d61ajrFrjc3JaKBORSn2HbnZpv01GzimJ
	pQMpSycCv4n7YSfr+ud8apxpkl6ykzkbTGN0M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ndY+j1l7M9PTDSr16zE1iIXNH0qnbpu+
	7hjaTZSADK/Z7X1YM2yRDILJZ0gSavyYenhUAFpw2+bPadHWwL7kd/HRFkWRJ+3a
	vzkhcPGYZbK0S9oVLStqfDPkMN/6pZDvB8UH2sbl3aIvGiPN7/1dz3uiwTwjA3jh
	fE5NBGkdrDE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5B1524C8F;
	Mon,  2 May 2011 16:38:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3B4BC4C8D; Mon,  2 May 2011
 16:38:28 -0400 (EDT)
In-Reply-To: <20110502193321.GB10487@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 2 May 2011 15:33:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 259EF048-74FC-11E0-98AC-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172629>

Jeff King <peff@peff.net> writes:

> On Mon, May 02, 2011 at 12:15:23PM -0700, Junio C Hamano wrote:
>
>> Either end of revision range operator can be omitted to default to
>> HEAD, as in "origin.." (what did I do since I forked) or "..origin" (what
>> did they do since I forked).  But this resulted in ".." to be interpreted
>> as an empty range "HEAD..HEAD", and worse yet, because ".." does exist on
>> the filesystem, we get this annoying output:
>> 
>>   $ cd Documentation/howto
>>   $ git log .. ;# give me recent commits that touch Documentation/ area.
>>   fatal: ambiguous argument '..': both revision and filename
>>   Use '--' to separate filenames from revisions
>> 
>> Surely we could say "git log .. --", but we shouldn't have to.
>
> I got slightly confused reading this, because I thought at first you
> wanted ".." to be some kind of magic rev specifier. In particular, your
> last line should say:
>
>   git log -- ..
>
> no?

Yeah, sorry about that.  Or "git log ../".

And a matching "rev-parse" update should look like this.  I wonder if we
could share some code between the two, though...

 Documentation/revisions.txt |    7 +++++++
 builtin/rev-parse.c         |   16 ++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index b290b61..ceed820 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -213,6 +213,13 @@ of 'r1' and 'r2' and is defined as
 It is the set of commits that are reachable from either one of
 'r1' or 'r2' but not from both.
 
+In these two shorthands, you can omit one end and let it default to HEAD.
+For example, 'origin..' is a shorthand for 'origin..HEAD' and asks "What
+did I do since I forked from the origin branch?"  Similarly, '..origin'
+is a shorthand for 'HEAD..origin' and asks "What did the origin do since
+I forked from them?"  Note that you cannot omit both ends.  '..' is not
+an empty range that is both reachable and unreachable from HEAD.
+
 Two other shorthands for naming a set that is formed by a commit
 and its parent commits exist.  The 'r1{caret}@' notation means all
 parents of 'r1'.  'r1{caret}!' includes commit 'r1' but excludes
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index adb1cae..3c8f171 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -223,6 +223,7 @@ static int try_difference(const char *arg)
 	const char *next;
 	const char *this;
 	int symmetric;
+	static const char head_by_default[] = "HEAD";
 
 	if (!(dotdot = strstr(arg, "..")))
 		return 0;
@@ -234,9 +235,20 @@ static int try_difference(const char *arg)
 	next += symmetric;
 
 	if (!*next)
-		next = "HEAD";
+		next = head_by_default;
 	if (dotdot == arg)
-		this = "HEAD";
+		this = head_by_default;
+
+	if (this == head_by_default && next == head_by_default &&
+	    !symmetric) {
+		/*
+		 * Just ".."?  That is not a range but the
+		 * pathspec for the parent directory.
+		 */
+		*dotdot = '.';
+		return 0;
+	}
+
 	if (!get_sha1(this, sha1) && !get_sha1(next, end)) {
 		show_rev(NORMAL, end, next);
 		show_rev(symmetric ? NORMAL : REVERSED, sha1, this);
