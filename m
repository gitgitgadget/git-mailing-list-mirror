From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH] unpack-trees: fix accidentally quadratic behavior
Date: Thu, 21 Jan 2016 14:09:58 -0500
Organization: Twitter
Message-ID: <1453403398.16226.40.camel@twopensource.com>
References: <1453349156-12553-1-git-send-email-dturner@twopensource.com>
	 <xmqq60ynzfyq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 20:10:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMKcR-00010v-EK
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 20:10:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760049AbcAUTKD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2016 14:10:03 -0500
Received: from mail-qg0-f49.google.com ([209.85.192.49]:36635 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759792AbcAUTKA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2016 14:10:00 -0500
Received: by mail-qg0-f49.google.com with SMTP id e32so39990705qgf.3
        for <git@vger.kernel.org>; Thu, 21 Jan 2016 11:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=KIKylBQVw1akay97v4xg1cSZs6BQdRdyFs3p4llCYNY=;
        b=S+t1kz+59HtjLePuCATvpVWwiJ7VJZjMrk17ovZ7C/ON+av36AEFP/fdAVgHkVzZFG
         An87B8H3h80OqdcUPUHmheLHnJ7D0+gJdXlkJOkvn0x6B61/42UZMh358o8jbmHxmZM/
         n+Mkdb3w2cqgYN1jHtqOR5LrjUTpTldBuXWXtfvf5Je3TCzxn7J/WvriIamUwYCEvfjM
         EIKyreEOX/IpJLIVMUgdvFwqHpsEgJf/LyI1kfU9CHiztDu6kMnXYeaD0j00Thddn17x
         z02ROnN4UHiThHBy+mMnlAOinnYyB5fj4WSVcn6fpK9wq9Gd9db7gwEmZw0rqEzIA1Xm
         WKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=KIKylBQVw1akay97v4xg1cSZs6BQdRdyFs3p4llCYNY=;
        b=FMtUpc4nrDv/PIyyw89gTJoEnlzWX37KbM1Gxuk6mk0SHUsmTkWp6jFBeY6iZskZ/I
         DFPs8RJW1PzpRh7xwtNejVC15cQCKv2WRnWyS86loAfX/9NL6QyioifJ7warQHnCa+Wk
         0No5t3YW4cyPczsnU1xgJ252DpEMdyKc95Ukbn/9mRZFoJ0EOxYWJyIUkmpqB+P20t1V
         aQvhI3XwA4k87Rual41fdOPd/qUp8Qn5bzTs7igXkj8wXKFvglRLor9lTCglto3eVyyJ
         V0CTyIuYFQeJ3KzGehJRWTZG+CEf00fkJWdTJSxPpkwyycusJYOAhs+qweS+4KUMdyXq
         N/7A==
X-Gm-Message-State: ALoCoQlOIB0PorXxRp8FwmJY13QcgOqUNH/KK/raGwfXU3a/uO1UoKWfHo9GRJtX/g0eMMDX6u9W+lyDQToHoYJ1v9dnKFj8Iw==
X-Received: by 10.140.16.225 with SMTP id 88mr55608036qgb.96.1453403399820;
        Thu, 21 Jan 2016 11:09:59 -0800 (PST)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id s90sm1143332qgs.13.2016.01.21.11.09.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 21 Jan 2016 11:09:58 -0800 (PST)
In-Reply-To: <xmqq60ynzfyq.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284519>

On Wed, 2016-01-20 at 20:58 -0800, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > While unpacking trees (e.g. during git checkout), when we hit a
> > cache
> > entry that's past and outside our path, we cut off iteration.
> > 
> > This provides about a 45% speedup on git checkout between master
> > and
> > master^20000 on Twitter's monorepo.  Speedup in general will depend
> > on
> > repostitory structure, number of changes, and packfile packing
> > decisions.
> > 
> > Signed-off-by: David Turner <dturner@twopensource.com>
> > ---
> 
> I haven't thought things through, but does this get fooled by the
> somewhat strange ordering rules of tree entries (i.e. a subtree
> sorts as if its name is suffixed with a '/' in a tree object)?
> 
> Other than that, I like this.  "We know the list is sorted, and
> after seeing this entry we know there is nothing that will match" is
> an obvious optimization that we already use elsewhere.
> 
> Thanks.

I think this is correct, because we first do the more complicated check
(ce_in_traverse_path), and only check the ordering once that has
failed.  The tests all pass, so this should be good.
