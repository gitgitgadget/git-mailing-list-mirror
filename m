From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 5/6] convert object type handling from a string to a number
Date: Tue, 27 Feb 2007 08:58:32 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0702270856360.29426@xanadu.home>
References: <11725197603476-git-send-email-nico@cam.org>
 <1172519760216-git-send-email-nico@cam.org>
 <11725197613482-git-send-email-nico@cam.org>
 <11725197622423-git-send-email-nico@cam.org>
 <11725197633144-git-send-email-nico@cam.org>
 <11725197632516-git-send-email-nico@cam.org>
 <7vejobhor2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 27 14:58:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM2qj-0003c0-Ak
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 14:58:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751635AbXB0N6e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 08:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751653AbXB0N6e
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 08:58:34 -0500
Received: from relais.videotron.ca ([24.201.245.36]:39896 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630AbXB0N6d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 08:58:33 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JE400ILQK5KCDW1@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Feb 2007 08:58:32 -0500 (EST)
In-reply-to: <7vejobhor2.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40734>

On Tue, 27 Feb 2007, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > We currently have two parallel notation for dealing with object types
> > in the code: a string and a numerical value.  One of them is obviously
> > redundent, and the most used one requires more stack space and a bunch
> > of strcmp() all over the place.
> >
> > This is an initial step for the removal of the version using a char array
> > found in object reading code paths.  The patch is unfortunately large but
> > there is no sane way to split it in smaller parts without breaking the
> > system.
> > ...
> > diff --git a/builtin-cat-file.c b/builtin-cat-file.c
> > index 6c16bfa..d61d3d5 100644
> > --- a/builtin-cat-file.c
> > +++ b/builtin-cat-file.c
> > @@ -79,7 +79,7 @@ static void pprint_tag(const unsigned char *sha1, const char *buf, unsigned long
> >  int cmd_cat_file(int argc, const char **argv, const char *prefix)
> >  {
> >  	unsigned char sha1[20];
> > -	char type[20];
> > +	enum object_type type;
> >  	void *buf;
> >  	unsigned long size;
> >  	int opt;
> > ...
> >  	case 'p':
> > -		if (sha1_object_info(sha1, type, NULL))
> > +		type = sha1_object_info(sha1, NULL);
> > +		if (type < 0)
> >  			die("Not a valid object name %s", argv[2]);
> 
> I am wondering if "enum object_type" and signed comparison here
> are compatible.

Enums are signed as far as I know.

> sha1_object_info() is of type "int" so that is
> clearly signed, but are we safe assuming this would not result
> in "type is unsigned and condition is always false"?

gcc would have warned about it if it was the case.


Nicolas
