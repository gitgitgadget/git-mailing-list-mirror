From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] read_in_full: always report errors
Date: Thu, 26 May 2011 13:53:09 -0700
Message-ID: <7vlixtw5e2.fsf@alter.siamese.dyndns.org>
References: <87tych5zrh.fsf@rho.meyering.net>
 <20110526141130.GB18520@sigill.intra.peff.net>
 <87hb8h5y09.fsf@rho.meyering.net>
 <20110526163027.GC4049@sigill.intra.peff.net>
 <7vy61twbqw.fsf@alter.siamese.dyndns.org>
 <20110526184839.GA6910@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jim Meyering <jim@meyering.net>, git list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 26 22:53:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPhYg-0003lp-G9
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 22:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754440Ab1EZUxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 16:53:20 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61515 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752321Ab1EZUxT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 16:53:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D7A1653C5;
	Thu, 26 May 2011 16:55:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3H4UK6eMgxfAKkI07RfaZvgrNLU=; b=jw9XFW
	+bxKKdhu79CqhNqisoyeYOgj9uf7sVgWF7zPu1yI5VAIq+PNsHvjke9sUE+n7QJj
	SQaRj+dpMOAGoeCvVUXrpoOEYZrxkTDsOYReh4KCafND1pbRn5vgsAZGXj6BIf3E
	hnfc+wlyZfaf15fugJWXWZnUJRProKpxU2QU0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CyObxYDPxeBnMC62VA2ZVo9A9GI8ugm1
	BZZEppFi26qLPls3vFVXEDjMsdSz1cNsPpi+1zRRqPn/4U4ZsOMZ3YVysKoPeYCp
	Ecoz0ng7/+ELiHk6n1j94/oj391kLCsre8djGbTJJoZCUxLSxV2lg4uqOZyH08tL
	AynRIxXrM8s=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A4D3F53B8;
	Thu, 26 May 2011 16:55:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2AC0553B7; Thu, 26 May 2011
 16:55:17 -0400 (EDT)
In-Reply-To: <20110526184839.GA6910@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 26 May 2011 14:48:40 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 791E8346-87DA-11E0-AB38-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174563>

Jeff King <peff@peff.net> writes:

> The problem is that most callers are not careful enough to repeatedly
> call read_in_full and find out that there might have been an error in
> the previous result. They see a read shorter than what they asked, and
> assume it was EOF.

I can buy that argument, but then shouldn't we change the "careful"
callers to treat any short-read from read_in_full() as an error?

After this patch, which you convinced me is a good thing to do overall,
they are no longer careful but are merely misguided that they can catch
and tell two kinds of errors apart.

Perhaps like this.  I notice that overall they are good changes, but the
one in pkt-line.c does not look very good.

 combine-diff.c |    5 +----
 csum-file.c    |    2 --
 pkt-line.c     |    6 ++----
 sha1_file.c    |    2 +-
 4 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index be67cfc..176231e 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -845,11 +845,8 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			result = xmalloc(len + 1);
 
 			done = read_in_full(fd, result, len);
-			if (done < 0)
+			if (done != len)
 				die_errno("read error '%s'", elem->path);
-			else if (done < len)
-				die("early EOF '%s'", elem->path);
-
 			result[len] = 0;
 
 			/* If not a fake symlink, apply filters, e.g. autocrlf */
diff --git a/csum-file.c b/csum-file.c
index fc97d6e..f5ac31f 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -19,8 +19,6 @@ static void flush(struct sha1file *f, void *buf, unsigned int count)
 
 		if (ret < 0)
 			die_errno("%s: sha1 file read error", f->name);
-		if (ret < count)
-			die("%s: sha1 file truncated", f->name);
 		if (memcmp(buf, check_buffer, count))
 			die("sha1 file '%s' validation error", f->name);
 	}
diff --git a/pkt-line.c b/pkt-line.c
index 5a04984..5628801 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -138,10 +138,8 @@ void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
 static void safe_read(int fd, void *buffer, unsigned size)
 {
 	ssize_t ret = read_in_full(fd, buffer, size);
-	if (ret < 0)
-		die_errno("read error");
-	else if (ret < size)
-		die("The remote end hung up unexpectedly");
+	if (ret != size)
+		die_errno("The remote end hung up unexpectedly");
 }
 
 static int packet_length(const char *linelen)
diff --git a/sha1_file.c b/sha1_file.c
index 8a85217..d1332c4 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2736,7 +2736,7 @@ static int index_stream(unsigned char *sha1, int fd, size_t size,
 		ssize_t actual;
 
 		actual = read_in_full(fd, buf, sz);
-		if (actual < 0)
+		if (actual != sz)
 			die_errno("index-stream: reading input");
 		if (write_in_full(fast_import.in, buf, actual) != actual)
 			die_errno("index-stream: feeding fast-import");
