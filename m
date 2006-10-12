From: apodtele <apodtele@gmail.com>
Subject: Re: [PATCH 1/2] diff --stat: use asymptotic scaling in graph
Date: Thu, 12 Oct 2006 17:37:14 -0400
Message-ID: <d620685f0610121437m38eb454g7597b2a93010b023@mail.gmail.com>
References: <d620685f0610121237k458665c5m7bbde2d565d7ef81@mail.gmail.com>
	 <20061012201646.GC10922@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Oct 13 00:27:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GY8F0-00065X-I1
	for gcvg-git@gmane.org; Thu, 12 Oct 2006 23:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbWJLVhS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 17:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbWJLVhR
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 17:37:17 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:50499 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751067AbWJLVhP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Oct 2006 17:37:15 -0400
Received: by wx-out-0506.google.com with SMTP id s14so674471wxc
        for <git@vger.kernel.org>; Thu, 12 Oct 2006 14:37:14 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=esOrgUHcdeJd86QdbCkvUMZlXEKPN87vQoglm7+6nIj0DTxL86loNtf9q49S1ssDROkstdPRG7nc3cyB+6wgFj3Q5Q6EFxSPkFND2xHTD7xqfwgKVukYCobGRt88Ihn/kEl2rnNNeNlpYQdshIdaL0x4fwKeDdMcYbTkz3Qb2Jc=
Received: by 10.90.32.19 with SMTP id f19mr1819230agf;
        Thu, 12 Oct 2006 14:37:14 -0700 (PDT)
Received: by 10.90.95.6 with HTTP; Thu, 12 Oct 2006 14:37:14 -0700 (PDT)
To: "Martin Waitz" <tali@admingilde.org>, git@vger.kernel.org
In-Reply-To: <20061012201646.GC10922@admingilde.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28805>

On 10/12/06, Martin Waitz <tali@admingilde.org> wrote:
> On Thu, Oct 12, 2006 at 03:37:17PM -0400, apodtele wrote:
> > Instead of conditionally scaling the stat graph for large changes,
> > always scale it asymptotically: small changes shall appear without any
> > distortions.
>
> very nice idea!
>
> > +     return it * width / (it + width) + 1;
>
> but wouldn't this formula result in at least 1, even for a 0 change?
> Perhaps we'd have to special case an input of 0?

Corrected patch follows.

--- diff.c	2006-10-12 14:45:13.000000000 -0400
+++ diff.c	2006-10-12 17:32:15.000000000 -0400
@@ -637,15 +637,12 @@

 const char mime_boundary_leader[] = "------------";

-static int scale_linear(int it, int width, int max_change)
+static int scale_nonlinear(int it, int width)
 {
-	/*
-	 * make sure that at least one '-' is printed if there were deletions,
-	 * and likewise for '+'.
-	 */
-	if (max_change < 2)
-		return it;
-	return ((it - 1) * (width - 1) + max_change - 1) / (max_change - 1);
+	if (it)
+		return it * width / (it + width) + 1;
+	else
+		return 0;
 }

 static void show_name(const char *prefix, const char *name, int len,
@@ -776,11 +773,9 @@
 		adds += add;
 		dels += del;

-		if (width <= max_change) {
-			add = scale_linear(add, width, max_change);
-			del = scale_linear(del, width, max_change);
-			total = add + del;
-		}
+		add = scale_nonlinear(add, width / 2);
+		del = scale_nonlinear(del, width / 2);
+		total = add + del;
 		show_name(prefix, name, len, reset, set);
 		printf("%5d ", added + deleted);
 		show_graph('+', add, add_c, reset);
