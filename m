From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: regression in  92392b4
Date: Wed, 23 Jul 2008 12:49:04 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807231246560.2830@eeepc-johanness>
References: <20080722231745.GD11831@artemis.madism.org> <20080723101415.GA23769@atjola.homenet>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="658432-398795248-1216810147=:2830"
Cc: Pierre Habouzit <madcoder@debian.org>, spearce@spearce.org,
	Git ML <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 23 12:49:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLbuC-0003Lv-1Z
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 12:49:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752389AbYGWKsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 06:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbYGWKsM
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 06:48:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:55892 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751496AbYGWKsL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 06:48:11 -0400
Received: (qmail invoked by alias); 23 Jul 2008 10:48:09 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp060) with SMTP; 23 Jul 2008 12:48:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/ipuQXHAriqp9PKFAcWmVJ4uOUb4mE/WbTquxe9I
	GwHRPC76crpJga
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080723101415.GA23769@atjola.homenet>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89627>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--658432-398795248-1216810147=:2830
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 23 Jul 2008, Björn Steinbrink wrote:

> On 2008.07.23 01:17:45 +0200, Pierre Habouzit wrote:
> >   Hi, here is a manual painful down-secting (opposed to a bisect ;P) I
> > did, since git in next cannot fetch on a regular basis for me. The
> > culprit seems to be commit  92392b4:
> > 
> >     ┌─(1:11)──<~/dev/scm/git 92392b4...>──
> >     └[artemis] git fetch
> >     remote: Counting objects: 461, done.
> >     remote: Compressing objects: 100% (141/141), done.
> >     remote: Total 263 (delta 227), reused 155 (delta 121)
> >     Receiving objects: 100% (263/263), 95.55 KiB, done.
> >     fatal: Out of memory, malloc failed
> >     fatal: index-pack failed
> >     [2]    16674 abort (core dumped)  git fetch
> > 
> >     ┌─(1:12)──<~/dev/scm/git 92392b4...>──
> >     └[artemis] git checkout -m HEAD~1; make git-index-pack
> >     Previous HEAD position was 92392b4... index-pack: Honor core.deltaBaseCacheLimit when resolving deltas
> >     HEAD is now at 03993e1... index-pack: Track the object_entry that creates each base_data
> >     GIT_VERSION = 1.5.6.3.3.g03993
> > 	CC index-pack.o
> > 	LINK git-index-pack
> > 
> >     ┌─(1:12)──<~/dev/scm/git 03993e1...>──
> >     └[artemis] git fetch
> >     remote: Counting objects: 461, done.
> >     remote: Compressing objects: 100% (141/141), done.
> >     remote: Total 263 (delta 227), reused 155 (delta 121)
> >     Receiving objects: 100% (263/263), 95.55 KiB, done.
> >     Resolving deltas: 100% (227/227), completed with 153 local objects.
> >     From git://git.kernel.org/pub/scm/git/git
> >        5ba2c22..0868a30  html       -> origin/html
> >        2857e17..abeeabe  man        -> origin/man
> >        93310a4..95f8ebb  master     -> origin/master
> >        559998f..e8bf351  next       -> origin/next
> > 
> > You can see the commit sha's in the prompt. 03993e1 is fine, 92392b4 is
> > broken, I've absolutely no clue about what happens.
> > 
> > All I can say is that at some point in get_data_from_pack, obj[1].idx
> > points to something that is *not* a sha so it's probably corrupted.
> > (from index-pack.c).
> 
> Here's how to reproduce:

Funny.  That does not reproduce the bug here at all.

But then, it is unsurprising, since both Pierre and me did something 
similar yesterday, fetching _just_ the pre-fetch refs into a freshly 
initted Git repository, and then fetching from kernel.org.

Tested on x86_64.

Ciao,
Dscho

--658432-398795248-1216810147=:2830--
