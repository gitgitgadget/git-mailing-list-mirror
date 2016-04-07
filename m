From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 03/16] index-helper: new daemon for caching index and
 related stuff
Date: Thu, 7 Apr 2016 16:14:50 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604071614250.2967@virtualbox>
References: <1459980722-4836-1-git-send-email-dturner@twopensource.com> <1459980722-4836-4-git-send-email-dturner@twopensource.com> <5705FC59.2050801@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	pclouds@gmail.com, aevarb@gmail.com, jeffhost@microsoft.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Apr 07 16:15:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoAiE-0002aY-3D
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 16:15:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756081AbcDGOPD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 10:15:03 -0400
Received: from mout.gmx.net ([212.227.15.18]:64109 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756054AbcDGOPB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 10:15:01 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Lymoh-1bqqU82wCt-016AT0; Thu, 07 Apr 2016 16:14:51
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <5705FC59.2050801@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:aXzW7cVfo+nL+hnVJoVQ7J8Zm7uyw3+8ii9mbrk2j6juDvte8A3
 vsRctgCroQjrAzCTf8Vh7PZQPZJXt7HzidTzfn/x7303Jw4gg6WdxYdoNkXOYg7n/l/WRfH
 3pBIQJvpviUJhU+J+1DhAcX8G7lnQLs0VwGcfZCETV4g6jue+y5R2CtoHvqI6/CtUIzUv6h
 0SB3OMLZ/1v1x8DkviKgg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fgFnOYXim60=:a48wILOwgxyR6bltXAu5Gb
 gBpYow8E40xZB45JsZ6McAEn5taL7DWdp6BDK9KXN0ZpLGpQTprxLRMfHurePlDsxLUPo9gYB
 WPwLi3JS7ISG8HgUpUZMH0x8OqsEWXmp+48Pv0vNDHXjbekYs831nurrHRXZO10MWrDCl/74j
 AkmvldN759ZUI3DT51aZ2Mo9CVEYBUuuMNdj7f5yJvuBnlT7x8DyuNSV2zGz7enIvOcD4wq9r
 P1qgT8dRuNElernCHgk2y/wgPmXxGdJcMKyD62vQpcXSI5uUpYmRIZovXf3/QcFv0CQJn9Ami
 Iot5/6zZCBlPnRlQ2bBuRrpKESfMcs9wQQbWOpcMpRIjObPs33SatRDG+MenSU2TDv1X9AmgX
 SCNz6pV1kQwZroxFZgbew29NTxrj+WWqIBlLswC/kdCGICHwSllYUyccPwPogbn+TYol7FsT0
 VGRchXvDhwsS5wvwJnYR55XP2k8w8176qD/X82vPh1zliWiVIAvpZ+DWrkZMltNeG1F+c9ILl
 1dw4zK9C918636dWkiQEW4Qdd6o0hSPhfxaYm3N8qm3rbnXvIzHwGqx/hWyMiH9BInQOV8vl1
 5KcY+v18om+0b64k2/vJGoAxWSz4VD6zPXMo5LFY0JVahI0cS0yluSHnF6ZIk3YSc3tL/gB8L
 fKOcrGUDQAygQBnGuSWq8joNzI4HRJZWAxMdbAzH8gCqjWu/OqdId3hlRMJertJz/00LBiKIK
 zKLhQgRoCo71lhMMpql2mF9ulXNeHHiWWTi6yUKbgJJ1bqp2pUkaj8Jig02KXj5FpgQyfFqe 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290913>

Hi,

On Thu, 7 Apr 2016, Johannes Sixt wrote:

> Am 07.04.2016 um 00:11 schrieb David Turner:
> > +static void share_index(struct index_state *istate, struct shm *is)
> > +{
> > +	void *new_mmap;
> > +	if (istate->mmap_size <= 20 ||
> > +	    hashcmp(istate->sha1,
> > +		    (unsigned char *)istate->mmap + istate->mmap_size - 20)
> > ||
> > +	    !hashcmp(istate->sha1, is->sha1) ||
> > +	    git_shm_map(O_CREAT | O_EXCL | O_RDWR, 0700, istate->mmap_size,
> > +			&new_mmap, PROT_READ | PROT_WRITE, MAP_SHARED,
> > +			"git-index-%s", sha1_to_hex(istate->sha1)) < 0)
> 
> Builds which have NO_MMAP set require that MAP_PRIVATE is set. So I would
> guess that at this point you leave those builds behind. Unless we declare
> such systems as hopelessly outdated and remove NO_MMAP and compat/mmap.c or
> you support index-helper only when NO_MMAP is not set.

I vote for the latter: support index-helper only when NO_MMAP is unset.

Ciao,
Dscho
