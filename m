From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 2/2] ignorecase: Fix git mv on insensitive filesystems
Date: Wed, 07 May 2014 11:01:06 -0700
Organization: Twitter
Message-ID: <1399485666.11843.68.camel@stross>
References: <xmqqoazaelmi.fsf@gitster.dls.corp.google.com>
	 <1399417144-24864-1-git-send-email-dturner@twopensource.com>
	 <1399417144-24864-2-git-send-email-dturner@twopensource.com>
	 <5369CFDE.2070207@viscovery.net> <1399480977.11843.62.camel@stross>
	 <xmqqha51bhxg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 07 20:01:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi69i-0000he-4D
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 20:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264AbaEGSBR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 14:01:17 -0400
Received: from mail-qc0-f170.google.com ([209.85.216.170]:53627 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255AbaEGSBM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 14:01:12 -0400
Received: by mail-qc0-f170.google.com with SMTP id i8so1553463qcq.29
        for <git@vger.kernel.org>; Wed, 07 May 2014 11:01:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=hvY7ptTZ+jf0/OoQzxYm6s7GDJEu6u7Gm1ReZaBvLtY=;
        b=Ygz87zsprgVClQrThgXFtRfrwskfJ67DjJz0Znzeg1rrYjLC0RdU682zfk5DYjON8g
         E8yK2H7teAt4T9mZRyH7oo7AO090s2Xg/Flu5rHUdOaMlNpS4BnaffqckGuTEGasyT3d
         RGjjWGPdOIJDSRDv9OoQ/6Vl76dZOMoWZ22+QKBCIw0E+O5MjwFWlRGajrjKiD6S0CP0
         8jKUPi6oILLYvgMhn6T8uZjEv90l2Vcc/PKIwWk//A6Ge/v9vAjwwgRR+aKaqPoBcUS8
         0VekbEbb4rXULMMeozhDmR5Tztgs8v6FdZTtpnDSHKGcewXxjUGmcTEGWH2PwB3ZLDTo
         OagA==
X-Gm-Message-State: ALoCoQkHwOqiT/PE9QmPunr28FVQ5HwWZu5ZgosLkXGsYw9wi7TLxGmXa5bn9EcdmJQWs42UthI5
X-Received: by 10.224.119.131 with SMTP id z3mr20914953qaq.91.1399485671509;
        Wed, 07 May 2014 11:01:11 -0700 (PDT)
Received: from [172.25.144.67] ([8.25.197.27])
        by mx.google.com with ESMTPSA id l46sm7883113qga.21.2014.05.07.11.01.09
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Wed, 07 May 2014 11:01:10 -0700 (PDT)
In-Reply-To: <xmqqha51bhxg.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248339>

On Wed, 2014-05-07 at 10:46 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > On Wed, 2014-05-07 at 08:17 +0200, Johannes Sixt wrote:
> >> >  		} else if (cache_name_pos(src, length) < 0)
> >> >  			bad = _("not under version control");
> >> > -		else if (lstat(dst, &st) == 0) {
> >> > +		else if (lstat(dst, &dst_st) == 0 &&
> >> > +			 (src_st.st_ino != dst_st.st_ino ||
> >> > +			  (src_st.st_ino == 0 && strcasecmp(src, dst)))) {
> >> 
> >> Don't do that. st_ino is zero on Windows only because we do not spend time
> >> to fill in the field. Don't use it as an indicator for a case-insensitive
> >> file system; zero may be a valid inode number on other systems.
> >
> > I don't think it is a problem if zero is a valid inode.  The only thing
> > that happens when there is a zero inode, is that we have to compare
> > filenames.  The inode check is just an optimization to avoid doing a
> > bunch of strcasecmp on systems that don't have to.
> 
> Am I correct to rephrase you that the code assumes that any
> filesystem that cannot give unique inum to different files will use
> 0 as the placeholder inum, so if src/dst share the same non-zero
> inum, it is guaranteed that is not a placeholder and we know they
> are different files without comparing the two paths?

Yes, this is indeed a fair rephrasing.  In fact, the entire zero-check
should not be necessary, as POSIX requires that the st_ino field has a
"meaningful" value.  So in the case that this ever runs into a problem,
we ought to wrap the lstat call with a compatibility layer anyway. 

But maybe there is an OS I'm not thinking of which fills in st_ino with
something else?
