From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 3/6] Make sure fsck_commit_buffer() does not run out
 of the buffer
Date: Thu, 11 Sep 2014 13:59:00 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1409111352130.990@s15462909.onlinehome-server.info>
References: <alpine.DEB.1.00.1408171840040.990@s15462909.onlinehome-server.info> <cover.1410356761.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.1409101552560.990@s15462909.onlinehome-server.info> <xmqqlhprgylt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 13:59:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XS31r-00084E-FE
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 13:59:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754420AbaIKL7F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 07:59:05 -0400
Received: from mout.gmx.net ([212.227.17.22]:49497 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754226AbaIKL7E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2014 07:59:04 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx101) with ESMTPSA (Nemesis) id 0MKLeM-1XTgv524ne-001jS9;
 Thu, 11 Sep 2014 13:59:01 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqlhprgylt.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:uK/hnFfZSc+J9Eb+S70hPDjSyuvz7kWD/XspA6fMkO8MTpKyZsv
 XFLzSiDx22kHFeJQxRF47VG4J3+vd5CDl0TTfhZpQASCd6lUVK1gYtqYzwyHeqIJ2Q8BMuV
 DeJyPbeMtU3kosp5szons6wzxW+Ixs5D02DWwWuk55xfFIF3Vk+q+GzuSd8iLZwX09thYnX
 Mv0ghfWtsNFdaMeb9TY8Q==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256836>

Hi Junio,

On Wed, 10 Sep 2014, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > diff --git a/fsck.c b/fsck.c
> > index dd77628..9dd7d12 100644
> > --- a/fsck.c
> > +++ b/fsck.c
> > @@ -237,6 +237,26 @@ static int fsck_tree(struct tree *item, int strict, fsck_error error_func)
> >  	return retval;
> >  }
> >  
> > +static int require_end_of_header(const void *data, unsigned long size,
> > +	struct object *obj, fsck_error error_func)
> > +{
> > +	const char *buffer = (const char *)data;
> > +	int i;
> > +
> > +	for (i = 0; i < size; i++) {
> > +		switch (buffer[i]) {
> > +		case '\0':
> > +			return error_func(obj, FSCK_ERROR,
> > +				"invalid message: NUL at offset %d", i);
> 
> Isn't this "invalid header"?  After all we haven't escaped this loop
> and haven't seen the message part of the commit object (and it is
> the same if you are going to later reuse this for tag objects).

My reasoning for keeping it saying "message" was that a message consists
of a header and a body. I will change it to "unterminated header" instead,
also in the error message when no NUL was found.

Ciao,
Dscho
