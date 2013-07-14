From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 07/19] make sure partially read index is not changed
Date: Sun, 14 Jul 2013 10:29:02 +0700
Message-ID: <CACsJy8A61gfWsMecJha-3GoWXFT0bb3zAMJ5YT-a=vs=_3WghQ@mail.gmail.com>
References: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com> <1373650024-3001-8-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 14 05:29:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyD0R-0007e1-A0
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 05:29:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752283Ab3GND3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jul 2013 23:29:33 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:50515 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260Ab3GND3d (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jul 2013 23:29:33 -0400
Received: by mail-oa0-f44.google.com with SMTP id l10so14257208oag.17
        for <git@vger.kernel.org>; Sat, 13 Jul 2013 20:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=EPOEH96GmpVwlFQbyHtQ5IT10J+iZksw/7j3Yb85ezw=;
        b=I6IhVOOIdS3uvV+q1xn7hGsfbv77z+xP1+9SZFikwUMO35ICF+bMbbDe90Q/SqQz8q
         qnE0Z4nQrgltwldrV7p7L1fY087iKOx+usrEiC6aCc0uV96DoGSDYXQHQeiaumf1Cwiz
         vW+1BsiKexHahG55QBifvN0bGKdo37G5mT7rEBf5saCgKUGGCy3QCyMRlje+5hwlGSiO
         lYo+SWkskdyhhGSGZDnmLeM8LRq/Xem02ZIobsdWJkSJCETDyxcTeZ+qxHuQ6mOJETT3
         HTTaHlVhtg3VBnY8CjpEuKsggbZhHKmF7vAvVmFVYNhFON1DaFDCbUu9GWj2jf9yuvVA
         +YoQ==
X-Received: by 10.182.110.164 with SMTP id ib4mr31303206obb.87.1373772572497;
 Sat, 13 Jul 2013 20:29:32 -0700 (PDT)
Received: by 10.76.88.230 with HTTP; Sat, 13 Jul 2013 20:29:02 -0700 (PDT)
In-Reply-To: <1373650024-3001-8-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230303>

On Sat, Jul 13, 2013 at 12:26 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> A partially read index file currently cannot be written to disk.  Make
> sure that never happens, by erroring out when a caller tries to change a
> partially read index.  The caller is responsible for reading the whole
> index when it's trying to change it later.
>
> Forcing the caller to load the right part of the index file instead of
> re-reading it when changing it, gives a bit of a performance advantage,
> by avoiding to read parts of the index twice.

If you want to be strict about this, put similar check in
fill_stat_cache_info (used by entry.c), cache_tree_invalidate_path and
convert the code base (maybe except unpack-trees.c, just put a check
in the beginning of unpack_trees()) to use wrapper function to change
ce_flags (some still update ce_flags directly, grep them). Some flags
are in memory only and should be allowed to change in partial index,
some are to be written on disk and should not be allowed.
-- 
Duy
