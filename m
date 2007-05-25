From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Enhance unpack-objects for extracting large objects
Date: Fri, 25 May 2007 15:52:48 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705251546260.3366@xanadu.home>
References: <46569C37.5000201@gmail.com>
 <7vsl9kr9mz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Dana How <danahow@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 25 21:52:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrfqM-0001ME-Ft
	for gcvg-git@gmane.org; Fri, 25 May 2007 21:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753115AbXEYTwx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 15:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753055AbXEYTwx
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 15:52:53 -0400
Received: from relais.videotron.ca ([24.201.245.36]:24745 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973AbXEYTwx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 15:52:53 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JIM004354K0GY00@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 25 May 2007 15:52:49 -0400 (EDT)
In-reply-to: <7vsl9kr9mz.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48403>

On Fri, 25 May 2007, Junio C Hamano wrote:

> Maybe we would want to call it '-f' for consistency.  Another
> possibility is the other way around, giving others a longer
> synonyms, like --quiet, but this command is plumbing and I do
> not think long options matters that much, so my preference is to
> do '-f' not '--force'.

OTOH, I like to have long options for weird or obscur parameters.  Their 
action is less likely to be presumed by casual inspection of a script 
using them.  I don't feel strongly about it either ways though.

> > @@ -131,7 +134,9 @@ static void added_object(unsigned nr, enum object_type type,
> >  static void write_object(unsigned nr, enum object_type type,
> >  			 void *buf, unsigned long size)
> >  {
> > -	if (write_sha1_file(buf, size, typename(type), obj_list[nr].sha1) < 0)
> > +	int force2 = size < min_blob_size ? -1 : force;
> > +	if (write_sha1_file_maybe(buf, size, typename(type),
> > +				  force2, obj_list[nr].sha1) < 0)
> >  		die("failed to write object");
> >  	added_object(nr, type, buf, size);
> >  }
> 
> Without --min-blob-size option, min_blob_size is initialized to
> 0u and force2 always gets the value of force.  With the option,
> blobs smaller than the threshold gets -1 and otherwise the value
> of force.
> 
> "write_sha1_file_maybe()" can take 0, 1, or -1 as its fourth
> parameter.  The reader is left puzzled what the distinction
> among these three and decides to read on to figure it out before
> complaining too much about the code, but no matter what it does,
> doesn't the above logic already feel wrong?
> 
>  * You already have the size here, so if min_blob_size is set
>    and the size is larger, you do not even have to call
>    write_sha1_file() at all.

You still do to get the object's SHA1.


Nicolas
