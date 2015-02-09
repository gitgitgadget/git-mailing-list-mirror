From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: git 2.2.2 annotate crash (strbuf.c:32)
Date: Mon, 9 Feb 2015 13:46:12 -0500
Message-ID: <20150209184612.GA4327@flurp.local>
References: <54D7D634.2050807@aegee.org>
 <20150209012858.GB21072@peff.net>
 <CAPig+cQ7iYq_c_MstfsMzArCZFM_0ORRa8Gi-YckaeZiWKN=4w@mail.gmail.com>
 <54D88D03.1090501@aegee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dilyan Palauzov <dilyan.palauzov@aegee.org>
X-From: git-owner@vger.kernel.org Mon Feb 09 19:46:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKtLl-0007RU-65
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 19:46:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933773AbbBISqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 13:46:20 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:41591 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760210AbbBISqT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 13:46:19 -0500
Received: by iecrd18 with SMTP id rd18so6713711iec.8
        for <git@vger.kernel.org>; Mon, 09 Feb 2015 10:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=eUXDfSuZPTkyTe5qKp+XribzN8S+CzHXVrqUFEhxSMU=;
        b=Q++rX33mV3/XPsa/1FTwo/FbIbcLVTsN1j6uiE1M6LjEfF3bwvg7Xw6i6U7KL3Wja6
         LjT7c99PmWCFytIGYQ0dL3yCRUBCt4cX0nAnVPTUrLFh7zr/0G1BouephzRCzmVUi+f6
         5ALUeK3PZOj5zkZIxymbti/vHcinlGqRDPQQS7L2GRTh5O9JS0ORHdEwRfidEYgGPsjp
         Nc0chLeAf+qkbW84BrRnW9RZSlbGP4X7Q+ypVb8gP2uNB4Vawp1GOjCaaaVq1JMdMCho
         o1PNhEyEocY2lHdfwPpLSjmFDZet0OG7g6DiX7NTcGtdVL5h/uYUNndqgzxEFKRffOR3
         DgrA==
X-Received: by 10.42.226.5 with SMTP id iu5mr13284425icb.0.1423507579135;
        Mon, 09 Feb 2015 10:46:19 -0800 (PST)
Received: from flurp.local (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id hi15sm6082655igb.19.2015.02.09.10.46.18
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 09 Feb 2015 10:46:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <54D88D03.1090501@aegee.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263579>

On Mon, Feb 09, 2015 at 11:33:39AM +0100, Dilyan Palauzov wrote:
> the point is that with exactly the same configuration on one
> computer there is crash and on another one things work just fine.
> 
> I found out that line builtin/blame.c:1675 makes the problems:
> 
> if (len) {
>   printf("blame.c:1676, subject: %s, len: %i\n", subject, len);
> -->  strbuf_add(&ret->summary, subject, len);  <--
> } else
>    strbuf_addf(&ret->summary, "(%s)", sha1_to_hex(commit->object.sha1));
> 
> commenting it out and compiling does not lead to crashing git
> anymore. You can find below the output of printf.
> 
> git clone git://git.cyrusimap.org/cyrus-imapd
> git annotate timsieved/parser.c
> 
> *** Error in `git': double free or corruption (!prev):
> 0x00000000022e4b40 ***

There is a bit of suspicious code in builtin/blame.c where it is
destroying the commit_info without ever initializing it, and this
happens many times when blaming 'timsieved/parser.c'. Does the
following patch fix the problem for you?

--- 8< ---
diff --git a/builtin/blame.c b/builtin/blame.c
index 303e217..a3cc972 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2085,7 +2085,6 @@ static void find_alignment(struct scoreboard *sb, int *option)
 
 	for (e = sb->ent; e; e = e->next) {
 		struct origin *suspect = e->suspect;
-		struct commit_info ci;
 		int num;
 
 		if (compute_auto_abbrev)
@@ -2096,6 +2095,7 @@ static void find_alignment(struct scoreboard *sb, int *option)
 		if (longest_file < num)
 			longest_file = num;
 		if (!(suspect->commit->object.flags & METAINFO_SHOWN)) {
+			struct commit_info ci;
 			suspect->commit->object.flags |= METAINFO_SHOWN;
 			get_commit_info(suspect->commit, &ci, 1);
 			if (*option & OUTPUT_SHOW_EMAIL)
@@ -2104,6 +2104,7 @@ static void find_alignment(struct scoreboard *sb, int *option)
 				num = utf8_strwidth(ci.author.buf);
 			if (longest_author < num)
 				longest_author = num;
+			commit_info_destroy(&ci);
 		}
 		num = e->s_lno + e->num_lines;
 		if (longest_src_lines < num)
@@ -2113,8 +2114,6 @@ static void find_alignment(struct scoreboard *sb, int *option)
 			longest_dst_lines = num;
 		if (largest_score < ent_score(sb, e))
 			largest_score = ent_score(sb, e);
-
-		commit_info_destroy(&ci);
 	}
 	max_orig_digits = decimal_width(longest_src_lines);
 	max_digits = decimal_width(longest_dst_lines);
-- 
2.3.0.rc2.191.g303d43c
--- 8< ---
