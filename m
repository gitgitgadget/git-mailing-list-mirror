From: Junio C Hamano <gitster@pobox.com>
Subject: Re: question: how to ignore extral CR when diff dos format files
 with 'color=auto'
Date: Wed, 27 Aug 2008 19:47:31 -0700
Message-ID: <7v7ia1kg8s.fsf@gitster.siamese.dyndns.org>
References: <1219728743111-783231.post@n2.nabble.com>
 <1219887555724-788498.post@n2.nabble.com>
 <7vbpzdkgy9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: goooguo <erwangg@fortemedia.com.cn>
X-From: git-owner@vger.kernel.org Thu Aug 28 04:48:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYXZ0-0001Kn-BN
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 04:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753724AbYH1Crm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 22:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753662AbYH1Crl
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 22:47:41 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53619 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753626AbYH1Crl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 22:47:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2BB7E5320F;
	Wed, 27 Aug 2008 22:47:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2F1755320E; Wed, 27 Aug 2008 22:47:33 -0400 (EDT)
In-Reply-To: <7vbpzdkgy9.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 27 Aug 2008 19:32:14 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AC64A52C-74AB-11DD-BAE1-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94029>

Junio C Hamano <gitster@pobox.com> writes:

> ...  I suspect
> that combined-diff output routines have the same issue that you need to
> fix the same way, but I didn't look.

Now I looked.  The combine-diff part should look like this, I think.

diff --git i/combine-diff.c w/combine-diff.c
index 534be38..de83c69 100644
--- i/combine-diff.c
+++ w/combine-diff.c
@@ -496,6 +496,18 @@ static int hunk_comment_line(const char *bol)
 	return (isalpha(ch) || ch == '_' || ch == '$');
 }
 
+static void show_line_to_eol(const char *line, int len, const char *reset)
+{
+	int saw_cr_at_eol = 0;
+	if (len < 0)
+		len = strlen(line);
+	saw_cr_at_eol = (len && line[len-1] == '\r');
+
+	printf("%.*s%s%s\n", len - saw_cr_at_eol, line,
+	       reset,
+	       saw_cr_at_eol ? "\r" : "");
+}
+
 static void dump_sline(struct sline *sline, unsigned long cnt, int num_parent,
 		       int use_color)
 {
@@ -589,7 +601,7 @@ static void dump_sline(struct sline *sline, unsigned long cnt, int num_parent,
 					else
 						putchar(' ');
 				}
-				printf("%s%s\n", ll->line, c_reset);
+				show_line_to_eol(ll->line, -1, c_reset);
 				ll = ll->next;
 			}
 			if (cnt < lno)
@@ -613,7 +625,7 @@ static void dump_sline(struct sline *sline, unsigned long cnt, int num_parent,
 					putchar(' ');
 				p_mask <<= 1;
 			}
-			printf("%.*s%s\n", sl->len, sl->bol, c_reset);
+			show_line_to_eol(sl->bol, sl->len, c_reset);
 		}
 	}
 }
