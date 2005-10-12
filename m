From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add '--create-index' to git-unpack-objects
Date: Wed, 12 Oct 2005 16:25:22 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510121612340.6307@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0510121301340.30679@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051012173426.56fd5c1c.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Oct 12 16:29:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPhXt-0003cw-DK
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 16:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbVJLOZ0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 10:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964792AbVJLOZ0
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 10:25:26 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:54717 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964791AbVJLOZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2005 10:25:26 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BA32813EEE2; Wed, 12 Oct 2005 16:25:24 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 98D63B4CE6; Wed, 12 Oct 2005 16:25:24 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 703EEB4CE1; Wed, 12 Oct 2005 16:25:24 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0BC8213EC95; Wed, 12 Oct 2005 16:25:22 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Sergey Vlasov <vsu@altlinux.ru>
In-Reply-To: <20051012173426.56fd5c1c.vsu@altlinux.ru>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10028>

Hi,

On Wed, 12 Oct 2005, Sergey Vlasov wrote:

> On Wed, 12 Oct 2005 13:02:36 +0200 (CEST) Johannes Schindelin wrote:
> 
> >  static void write_object(void *buf, unsigned long size, const char *type)
> >  {
> >  	unsigned char sha1[20];
> > -	if (write_sha1_file(buf, size, type, sha1) < 0)
> > +	if (create_index) {
> > +		char header[100];
> > +		SHA_CTX c;
> > +
> > +		SHA1_Init(&c);
> > +		SHA1_Update(&c, header, 1+sprintf(header, "%s %lu", type, size));
> > +		SHA1_Update(&c, buf, size);
> > +		SHA1_Final(current_sha1, &c);
> > +	} else if (write_sha1_file(buf, size, type, sha1) < 0)
> >  		die("failed to write object");
> 
> Sorry, but this cannot work.  git-unpack-objects does a streaming
> unpack, and it needs to be able to read back the objects it has written
> out previously (in case a delta later in the stream references some
> older object).

Even worse, my code did not anticipate that the base objects could have 
been handled earlier (and thus the deltas would never be resolved).

> Saving unpacked objects in memory would obviously be unacceptable.

Actually, this is what git-unpack-objects does. All unresolved deltas are 
stored in a linked list, and handled later.

Of course, it would be nicer to use a seekable file if you have one. But 
then, I am not at all sure that base objects should be allowed to come 
later in the file: since the delta chains must not be cyclic, the objects
can be sorted. Thus, it could be guaranteed that the base objects are 
already unpacked when unpacking the derived object.

Ciao,
Dscho
