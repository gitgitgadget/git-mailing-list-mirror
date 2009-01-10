From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH 2/3] replace_object: add mechanism to replace objects found in "refs/replace/"
Date: Sat, 10 Jan 2009 08:30:39 -0800 (PST)
Message-ID: <m3tz87yvh4.fsf@localhost.localdomain>
References: <20090107084341.1554d8cd.chriscool@tuxfamily.org>
	<7vmye3a4pt.fsf@gitster.siamese.dyndns.org>
	<200901081831.22616.chriscool@tuxfamily.org>
	<7v8wpl4akr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Summary: Idea for large binary files in Git using refs/replace/
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Tim Ansell <mithro@mithis.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 17:32:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLgkp-0005VL-9M
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 17:32:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752539AbZAJQao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 11:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752531AbZAJQan
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 11:30:43 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:22806 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752399AbZAJQam (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 11:30:42 -0500
Received: by ey-out-2122.google.com with SMTP id 22so1204952eye.37
        for <git@vger.kernel.org>; Sat, 10 Jan 2009 08:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:summary:from
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :date;
        bh=KCYR7+pLWUa4BMSL2so6cvWYYSRwrWvEYybdIZM0Xsw=;
        b=CF1FXnTV1C3CjKHRah0SND02+6bLljTHZ04sqQ30kfs0JbICcno4tVrGTNd5DzPThR
         Xph0LdA32jh5CrOAxv/jpxinrb9JRxK4QRl0g2xZO9Zqq+KcS5QWgpzhZAVr4jYpKuAW
         q9zaqtAyZBXgLs85cAo32CNuzgUBJBXEVNeuI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:summary:from
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :date;
        b=tLPf8rDwdsX5ErCOiuj/065ivpBUeWKjXrPRSdHVr/gsE2YgOWlwZh8QHuxwPx21Gi
         h8rXllNRrFo6cTkd7PEeWM2R94nkmH8TV7zU1PMp+tIpF9ZxeN7e9L24p5PIAfX7cly9
         SMac76/mjegh3ibKxNe1iHU9HrjdJdr+GrgjQ=
Received: by 10.210.87.19 with SMTP id k19mr6041348ebb.141.1231605040550;
        Sat, 10 Jan 2009 08:30:40 -0800 (PST)
Received: from localhost.localdomain (abve97.neoplus.adsl.tpnet.pl [83.8.202.97])
        by mx.google.com with ESMTPS id 28sm2752720eyg.4.2009.01.10.08.30.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Jan 2009 08:30:39 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n0AGUaKU001805;
	Sat, 10 Jan 2009 17:30:37 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n0AGUVOg001802;
	Sat, 10 Jan 2009 17:30:31 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7v8wpl4akr.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105128>

Junio C Hamano <gitster@pobox.com> writes:
> Christian Couder <chriscool@tuxfamily.org> writes:
> 
> > Yeah, but read_sha1_file is called to read all object files, not just 
> > commits. So putting the hook there will:
> >
> > 	1) add a lookup overhead when reading any object,
> > 	2) make it possible to replace any object,
> 
> I actually see (2) as an improvement, and (1) as an associated cost.

I just had an idea: we can use this mechanism to better manage large
binary files in Git, by using replacements for _blobs_.

We want to be able to have two flavours of repository: one with large
blobs (media files usually), and one without.  We can use stubs in the
place of large binary files in 'no-megablobs' flavor, and add contents
of those files via refs/replace/* for _blobs_ in 'with-megablobs'
flavour.  We can control which objects we want to have, and which
objects to transfer.

What do you think about this (abuse of) an idea?
-- 
Jakub Narebski
Poland
ShadeHawk on #git
