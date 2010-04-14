From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 8/9] builtin: check pager.<cmd> configuration if
 RUN_SETUP_GENTLY is used
Date: Wed, 14 Apr 2010 00:06:44 -0500
Message-ID: <20100414050643.GB28864@progeny.tock>
References: <20100413021153.GA3978@progeny.tock>
 <20100413023003.GH4118@progeny.tock>
 <y2yfcaeb9bf1004130312l197983cnf92371acc88464db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 14 07:06:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1uoQ-0002Pk-KX
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 07:06:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787Ab0DNFGs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Apr 2010 01:06:48 -0400
Received: from mail-yw0-f194.google.com ([209.85.211.194]:55045 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097Ab0DNFGr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 01:06:47 -0400
Received: by ywh32 with SMTP id 32so2673163ywh.33
        for <git@vger.kernel.org>; Tue, 13 Apr 2010 22:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Vj7YM9m7S+lZ+41CVh1RT/6ppLfiQ3vsoQYpbuwm9cY=;
        b=BFlaee1ZqEP8DdwEs2CF8qhYkWc6G4L2dNHPbcVzGuPCel6dkfb4SzWU4hfdIBf197
         fA8uj+rLKzkfy4S6Kd3V94cAv2iV/74RL137OG6h6thSHgyl0pG5j5kzUCwzVzgsmPH5
         +odFw98GUbMo1YmopRE2c/KuiwMBSNkCOxMwM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=hs+3BFkL8AWCvHo4yz55didF1BOVBA0acPC4tWqEdbO4r07h2r4QoESxqZxU3V46HT
         EsYX8QJ2DCQhkF/jI0vqGqr9x2vFGSHA+JVoNGMguizhAUmNGidnSzICSbriyrIsC5z2
         fvTDQW5/ZgwnsZzToMj9dDrL+XtbdALgstYpw=
Received: by 10.101.167.19 with SMTP id u19mr12384856ano.26.1271221604750;
        Tue, 13 Apr 2010 22:06:44 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm5440611iwn.5.2010.04.13.22.06.43
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 13 Apr 2010 22:06:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <y2yfcaeb9bf1004130312l197983cnf92371acc88464db@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144849>

Nguyen Thai Ngoc Duy wrote:

> there's another case, when RUN_SETUP_GENTLY is
> set, but no repository is found. git_config() will pick
> $(cwd)/.git/config if it exists. I guess it's OK for this series
> because the true fix will require more changes.

I have claimed before that it=E2=80=99s better to fix a few bugs now an=
d
provide a solid foundation to build on than to try to do everything
right away.  Sounds good in principle, but in practice we have to look
to the future to decide whether the foundation is strong enough.

So here are some ideas for future work (not necessarily in order).

 - Teach remaining commands that need to search for a repository to
   use RUN_SETUP_GENTLY, with appropriate exceptions where needed
   (for --no-index, for example).

 - Introduce unset_git_directory and the RUN_UNSETUP option (yes,
   this needs a better name).  Teach commands that work without a
   git directory to use it (this should fix the init poisoned by
   parent repository and aliased init problems).

 - Teach git_config() to ignore the repository-specific configuration
   if have_run_setup is true but have_repository is false.

 - Teach git_attr() to ignore .git/info/attributes if have_run_setup
   is true but have_repository is false.

 - Teach git_config() to optionally die if have_run_setup is not true
   and the setup_git_dir* to optionally die if have_run_setup is true.
   test-lib.sh would enable this option.

Sane?
Jonathan
