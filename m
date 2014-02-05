From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] reset: support "--mixed --intent-to-add" mode
Date: Wed, 5 Feb 2014 07:27:26 +0700
Message-ID: <20140205002725.GA3858@lanh>
References: <CACsJy8BXGZ+1Oqrpcky5JPCtZRwvxmxhXGfuEqY9Ct4Pt8FmJg@mail.gmail.com>
 <1391480409-25727-1-git-send-email-pclouds@gmail.com>
 <1391480409-25727-2-git-send-email-pclouds@gmail.com>
 <xmqqvbwu8zjx.fsf@gitster.dls.corp.google.com>
 <xmqqeh3i7bxm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 05 01:27:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAqKz-0006t7-D8
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 01:27:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753880AbaBEA12 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 19:27:28 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:64740 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545AbaBEA11 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 19:27:27 -0500
Received: by mail-pa0-f47.google.com with SMTP id kp14so9156114pab.6
        for <git@vger.kernel.org>; Tue, 04 Feb 2014 16:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Ev5EbidHr4TuEfqqzoFnSf2gD0hr12AJGPYZm7gwCt0=;
        b=dwOZkXF1TLjz0AK1ZWzqssddtpx61ajwsp8ki4ENcYPRQjwRz20tfHn0ANUBFxku25
         d1GMMuUMQ7wlXEsMDaGoU1/Y9jV2SddVaefuNu2WxxiDLkxcNzDDH6UxVy6ENQ+Ok06J
         jLXgsJsRMJecLtXrcILOKenLMs/67jqFteWSxOMHl6zVaYSGEG3hX/JyxjcrvWitt+Be
         5NL65AfzR82YZhkTSXbF5tdEHHrIf37Vs+VHNK3gipMtHjax/tGOnVmQGAlw9bFrsHzj
         jfBrIVi0i+Zx8dvatiJgr1FZ9giADkDe1IT0BNSwHvuGmQz1gy8dqGAAfxBGSwTNVkHx
         C6pA==
X-Received: by 10.66.13.138 with SMTP id h10mr13140350pac.148.1391560047159;
        Tue, 04 Feb 2014 16:27:27 -0800 (PST)
Received: from lanh ([115.73.225.58])
        by mx.google.com with ESMTPSA id nu10sm70164232pbb.16.2014.02.04.16.27.24
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 04 Feb 2014 16:27:26 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 05 Feb 2014 07:27:26 +0700
Content-Disposition: inline
In-Reply-To: <xmqqeh3i7bxm.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241588>

On Tue, Feb 04, 2014 at 02:25:25PM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > While I do not have any problem with adding an optional "keep lost
> > paths as intent-to-add entries" feature, I am not sure why this has
> > to be so different from the usual add-cache-entry codepath.  The
> > if/elseif chain you are touching inside this loop does:
> >
> >  - If the tree you are resetting to has something at the path
> >    (which is different from the current index, obviously), create
> >    a cache entry to represent that state from the tree and stuff
> >    it in the index;
> >
> >  - Otherwise, the tree you are resetting to does not have that
> >    path.  We used to say "remove it from the index", but now we have
> >    an option to instead add it as an intent-to-add entry.
> >
> > So, why doesn't the new codepath do exactly the same thing as the
> > first branch of the if/else chain and call add_cache_entry but with
> > a ce marked with CE_INTENT_TO_ADD?  That would parallel what happens
> > in "git add -N" better, I would think, no?
> 
> In other words, something along this line, perhaps?

<snip>

Yes. But you need something like this on top to actually set
CE_INTENT_TO_ADD

-- 8< --
diff --git a/read-cache.c b/read-cache.c
index 325d193..87f1367 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -585,6 +585,7 @@ void mark_intent_to_add(struct cache_entry *ce)
 	if (write_sha1_file("", 0, blob_type, sha1))
 		die("cannot create an empty blob in the object database");
 	hashcpy(ce->sha1, sha1);
+	ce->ce_flags |= CE_INTENT_TO_ADD;
 }
 
 int add_to_index(struct index_state *istate, const char *path, struct stat *st, int flags)
-- 8< --
