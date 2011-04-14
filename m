From: Junio C Hamano <gitster@pobox.com>
Subject: Re: textconv not invoked when viewing merge commit
Date: Thu, 14 Apr 2011 12:43:00 -0700
Message-ID: <7vd3kohb5n.fsf@alter.siamese.dyndns.org>
References: <201104111912.47547.kumbayo84@arcor.de>
 <4DA415AB.9020008@drmicha.warpmail.net>
 <20110414190901.GA1184@sigill.intra.peff.net>
 <7vipughbxh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Peter Oberndorfer <kumbayo84@arcor.de>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 14 21:43:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QASRk-0006qe-Cy
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 21:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758782Ab1DNTnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 15:43:14 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45973 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757532Ab1DNTnN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 15:43:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C31EA4A37;
	Thu, 14 Apr 2011 15:45:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NheQODFlEM8xY9vDhZ+1Cc8rkT8=; b=n8HVnG
	RwJ1Bj5iJu+mY7hMfNohL+Jj/eZrYZNsCQt9SuTFHX6NhNfm1iA2uB+Cmuv4acAm
	jO2pUXAe81UIKAgQx2SR5T8sRLyxS/TgSjzQuGH4CCKTUsWze+5ozVG0flWAwe0P
	9h5SUtPxkyg3TxuEVVe4TOL+tuOtAIAghm4Iw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r/HNhYAvR5THJ2jpa0iElgbODxMtYMf/
	CQwKRzBDqHD480TWdAKrhNE6Gu8vuwp/2Ptw+AKJxo5pcqIwa9i2KukIIOXhWEwg
	Ndmczgou077k/A0jCgQJrAcuoZhQXzM4uzdJCFPakYagTOcy9pPmaGUrCyfpsZYW
	51wzj747R7Y=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 80CA04A35;
	Thu, 14 Apr 2011 15:45:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 059CF4A34; Thu, 14 Apr 2011
 15:45:00 -0400 (EDT)
In-Reply-To: <7vipughbxh.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 14 Apr 2011 12:26:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B2C23AB0-66CF-11E0-9FDC-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171542>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> We just dump the binary goo all over the terminal. So I think the whole
>> combined-diff code path needs to learn how to handle binaries properly.
>
> How would you show multi-way diffs for binary files?
>
> It would probably be sufficient to say "binary files differ" at the
> beginning of the patch-combining codepath of the combined diff, which
> would at least keep the --raw -c/--cc output working.

In other words, I suspect that the only places you need to touch in the
existing codepath would be these places.

diff --git a/combine-diff.c b/combine-diff.c
index 655fa89..9c96f1f 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -201,7 +201,7 @@ static void consume_line(void *state_, char *line, unsigned long len)
 	}
 }
 
-static void combine_diff(const unsigned char *parent, unsigned int mode,
+static int combine_diff(const unsigned char *parent, unsigned int mode,
 			 mmfile_t *result_file,
 			 struct sline *sline, unsigned int cnt, int n,
 			 int num_parent, int result_deleted)
@@ -215,10 +215,17 @@ static void combine_diff(const unsigned char *parent, unsigned int mode,
 	unsigned long sz;
 
 	if (result_deleted)
-		return; /* result deleted */
+		return 0; /* result deleted */
 
 	parent_file.ptr = grab_blob(parent, mode, &sz);
 	parent_file.size = sz;
+
+	if (path has textconv) {
+		parent_file.{ptr,size} = textconv of parent_file;
+	} else if (path is binary) {
+		return -1;
+	}
+
 	memset(&xpp, 0, sizeof(xpp));
 	xpp.flags = 0;
 	memset(&xecfg, 0, sizeof(xecfg));
@@ -255,6 +262,7 @@ static void combine_diff(const unsigned char *parent, unsigned int mode,
 			p_lno++; /* no '+' means parent had it */
 	}
 	sline[lno].p_lno[n] = p_lno; /* trailer */
+	return 0;
 }
 
 static unsigned long context = 3;
@@ -777,6 +785,12 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			close(fd);
 	}
 
+	if (path has textconv) {
+		result, result_size = textconv of result;
+	} else if (path is binary) {
+		goto exit_binary;
+	}
+
 	for (cnt = 0, cp = result; cp < result + result_size; cp++) {
 		if (*cp == '\n')
 			cnt++;
@@ -820,11 +834,13 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 				break;
 			}
 		}
-		if (i <= j)
-			combine_diff(elem->parent[i].sha1,
-				     elem->parent[i].mode,
-				     &result_file, sline,
-				     cnt, i, num_parent, result_deleted);
+		if (i <= j) {
+			if (combine_diff(elem->parent[i].sha1,
+					 elem->parent[i].mode,
+					 &result_file, sline,
+					 cnt, i, num_parent, result_deleted))
+				goto exit_binary;
+		}
 		if (elem->parent[i].mode != elem->mode)
 			mode_differs = 1;
 	}
@@ -892,6 +908,8 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 		dump_sline(sline, cnt, num_parent,
 			   DIFF_OPT_TST(opt, COLOR_DIFF), result_deleted);
 	}
+
+free_exit:
 	free(result);
 
 	for (lno = 0; lno < cnt; lno++) {
@@ -906,6 +924,11 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 	}
 	free(sline[0].p_lno);
 	free(sline);
+	return;
+
+exit_binary:
+	printf("path '%s' is binary\n", elem->path);
+	goto free_exit;
 }
 
 #define COLONS "::::::::::::::::::::::::::::::::"
