From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [PATCH] basic threaded delta search
Date: Fri, 7 Sep 2007 08:11:05 +0200
Message-ID: <20070907061105.GA1379@auto.tuwien.ac.at>
References: <11890591912193-git-send-email-nico@cam.org> <11890591923123-git-send-email-nico@cam.org> <11890591923270-git-send-email-nico@cam.org> <1189059193250-git-send-email-nico@cam.org> <7vwsv4cm6b.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.9999.0709061014280.21186@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Sep 07 08:13:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITX67-0007aQ-DE
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 08:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbXIGGLK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 7 Sep 2007 02:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752216AbXIGGLJ
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 02:11:09 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:41229 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbXIGGLI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 02:11:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 1F9F1795D1AE;
	Fri,  7 Sep 2007 08:11:06 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UbCkDK9WJdEL; Fri,  7 Sep 2007 08:11:05 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 83B9D795D1AB; Fri,  7 Sep 2007 08:11:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0709061014280.21186@xanadu.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57982>

On Thu, Sep 06, 2007 at 10:48:06AM -0400, Nicolas Pitre wrote:
> On Thu, 6 Sep 2007, Junio C Hamano wrote:
> > Also how would this interact with the LRU
> > delta base window we discussed a week or two ago?
>=20
> This is completely orthogonal.

Maybe we should adjust the split point of the the object list so, that
objects with the same name hash are processed by one thread, as the LRU
could provide the most benefit for these objects.

I think of something like (totally untested):
        for (i =3D 0; i < NR_THREADS; i++) {
                unsigned sublist_size =3D list_size / (NR_THREADS - i);
+		while (sublist_size < list_size && list[0]->hash =3D=3D list[1]->has=
h)
+			sublist_size++;
                p[i].list =3D list;
                p[i].list_size =3D sublist_size;
                p[i].window =3D window;
                p[i].depth =3D depth;
                p[i].processed =3D processed;
                ret =3D pthread_create(&p[i].thread, NULL,
                                     threaded_find_deltas, &p[i]);
                if (ret)
                        die("unable to create thread: %s", strerror(ret=
));
                list +=3D sublist_size;
                list_size -=3D sublist_size;
        }

mfg Martin K=F6gler
