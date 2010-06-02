From: Simo Melenius <simo.melenius@iki.fi>
Subject: Bug? "git branch" failing to list all branches
Date: Wed, 2 Jun 2010 17:47:41 +0300
Message-ID: <AANLkTimTOucIfzSxsYNvmML7MALwj0E3BUASIIKIN1lN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 02 16:47:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJpEU-00061f-3t
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 16:47:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367Ab0FBOrp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 10:47:45 -0400
Received: from mail-yw0-f179.google.com ([209.85.211.179]:56294 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932340Ab0FBOro (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 10:47:44 -0400
Received: by ywh9 with SMTP id 9so5060326ywh.17
        for <git@vger.kernel.org>; Wed, 02 Jun 2010 07:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=pkQvpRX1TItMZHSyuxtpx4HbD2IE41VL+WbOTIzpp9s=;
        b=FR4VV9IFbkNJXLAhKfUw+zcTNo3lyVI5h8/nwDnu7k5TXBUM+Zo21cW/KurewCmZZd
         dQGKdHWgYDbhSG6iFXBWl2j4EobK+WDhh1OpK1CMQhKVpLAsM2OdyuKyai/wjM4sJtZB
         +u+r/u+VAjIOPhGLg6CsJnIWNGsiIfS2mKkPs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=hZ7hWJj/NPr3/8++eilD1C1D2fwpUalBwx2FHaggACqEq3jPark/r9Vs1K6u+4NujL
         Xrq354DHvSJLzQkQsp6pq3ERCx7DrZotIZbViXb29wj+FnvpqXERkxG1W9BUEuzXY9YX
         aboFR+0siBe9PqMLOrueqQXH3yRyzn5xdz9CY=
Received: by 10.150.188.6 with SMTP id l6mr7946299ybf.187.1275490061235; Wed, 
	02 Jun 2010 07:47:41 -0700 (PDT)
Received: by 10.150.186.2 with HTTP; Wed, 2 Jun 2010 07:47:41 -0700 (PDT)
X-Google-Sender-Auth: pSwdd0T5yIXGzAd4auHlKclJ1I8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148253>

I consider this a bug and wrote a fix. I would now like to ask the git
maintainers' opinion with regard to it.

When listing branches, "git branch" will in certain cases terminate
iteration at the first broken ref that doesn't point to a commit. This
will silently hide any remaining refs from the output listing.
However, this failure is not communicated upwards either, so I think
append_ref() goes wrong to terminate the whole loop because of this.

I noticed this because "git branch -a" and "git branch -av"
unexpectedly gave a very different output.


Simo

diff --git a/builtin/branch.c b/builtin/branch.c
index 6cf7e72..1a8e3d3 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -294,7 +294,10 @@ static int append_ref(const char *refname, const
unsigned char *sha1, int flags,
        if (ref_list->verbose || ref_list->with_commit || merge_filter
!= NO_FILTER) {
                commit = lookup_commit_reference_gently(sha1, 1);
                if (!commit)
-                       return error("branch '%s' does not point at a
commit", refname);
+               {
+                       error("branch '%s' does not point at a
commit", refname);
+                       return 0;
+               }

                /* Filter with with_commit if specified */
                if (!is_descendant_of(commit, ref_list->with_commit))

-- 
() Today is the car of the cdr of your life.
/\ http://arc.pasp.de/
