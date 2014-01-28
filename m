From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 3/3] diff: turn skip_stat_unmatch on selectively
Date: Wed, 29 Jan 2014 06:52:03 +0700
Message-ID: <20140128235203.GA7788@lanh>
References: <1390632411-3596-3-git-send-email-pclouds@gmail.com>
 <1390863568-22656-1-git-send-email-pclouds@gmail.com>
 <xmqqd2jdm1jj.fsf@gitster.dls.corp.google.com>
 <xmqq7g9jlny6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 29 00:46:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8IMR-0000Im-6e
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jan 2014 00:46:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755952AbaA1Xq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jan 2014 18:46:26 -0500
Received: from mail-pd0-f173.google.com ([209.85.192.173]:64131 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755934AbaA1XqY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jan 2014 18:46:24 -0500
Received: by mail-pd0-f173.google.com with SMTP id y10so968358pdj.18
        for <git@vger.kernel.org>; Tue, 28 Jan 2014 15:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=xXl0XNW6TBb7e+IWqNhBUGRWTVE57b9mDcxz0TDTgQE=;
        b=MTOjPh/Pm259rv/F5w4Ltjiu7yFfIdg/LWcn0FoVamYKvqCiFvhn0qQf0QesjIlCA1
         zlEJxY6uthTIbRjI0pDAFPVseNlOPC+286erPDjCxq1eKTZD6utFkqI9u7sX9yjUNkGi
         +qpCJ4G44vA+N68HkwD9pIToKEfGA8gCVmfmH74eEoLGSaU7YS4wAnwuCpsMz27rCRZm
         qjRM5eOZown7pZ18wbbdj3CqI6fVZFH3xTH/pyRLWLdiHvUQxt4dxAog3P/yABIop+qw
         +xXc8hB4yG6vj4Ao4HA0fdAMKq0pMIrmx74oYwBEcf/qrqYodx5cBfBFMNqBpjItwpZW
         evLw==
X-Received: by 10.68.232.132 with SMTP id to4mr4307577pbc.141.1390952783378;
        Tue, 28 Jan 2014 15:46:23 -0800 (PST)
Received: from lanh ([115.73.200.7])
        by mx.google.com with ESMTPSA id hb10sm630619pbd.1.2014.01.28.15.46.20
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 28 Jan 2014 15:46:22 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 29 Jan 2014 06:52:03 +0700
Content-Disposition: inline
In-Reply-To: <xmqq7g9jlny6.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241199>

On Tue, Jan 28, 2014 at 02:51:45PM -0800, Junio C Hamano wrote:
> >>  This replaces 'diff: turn off skip_stat_unmatch on "diff --cached"'
> >>  The previous patch obviously leaves skip_stat_unmatch on in "diff
> >>  <rev> <rev>" and maybe other cases.
> >
> > Oops, I lost track.  Sorry.
> 
> Together with {1,2}/3 applied on maint-1.8.4, this sems to break
> t3417 (there may be others, but I didn't have time to check).

My bad. I thought I covered all cases in my last patch (and didn't
retest it!). It turns out I should have set skip_stat_unmatch in
builtin_diff_b_f() too. This on top of 3/3 passes the tests

-- 8< --
diff --git a/builtin/diff.c b/builtin/diff.c
index 88542d9..8ab5e3d 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -89,6 +89,7 @@ static int builtin_diff_b_f(struct rev_info *revs,
 	if (blob[0].mode == S_IFINVALID)
 		blob[0].mode = canon_mode(st.st_mode);
 
+	revs->diffopt.skip_stat_unmatch = !!diff_auto_refresh_index;
 	stuff_change(&revs->diffopt,
 		     blob[0].mode, canon_mode(st.st_mode),
 		     blob[0].sha1, null_sha1,
-- 8< --
