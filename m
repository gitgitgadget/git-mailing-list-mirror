From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 08/13] prevent try_delta from using objects not in pack
Date: Fri, 06 Apr 2007 10:59:39 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704060859230.28181@xanadu.home>
References: <56b7f5510704051535ya98e86eu7f786f118c4fe229@mail.gmail.com>
 <alpine.LFD.0.98.0704052100420.28181@xanadu.home>
 <56b7f5510704051928l5d1f5a02yccc8e57c222e5f64@mail.gmail.com>
 <alpine.LFD.0.98.0704052320560.28181@xanadu.home>
 <56b7f5510704052047r30166e53kffbdd8bf71885264@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 17:46:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZpv3-0001uw-S4
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 17:00:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932753AbXDFO7m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 10:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932771AbXDFO7m
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 10:59:42 -0400
Received: from relais.videotron.ca ([24.201.245.36]:49795 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932753AbXDFO7l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 10:59:41 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JG3005110BG5W50@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 06 Apr 2007 10:59:40 -0400 (EDT)
In-reply-to: <56b7f5510704052047r30166e53kffbdd8bf71885264@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43913>

On Thu, 5 Apr 2007, Dana How wrote:

> Currently we have get_object_list -> traverse_commit_list ->
> show_{commit,object} -> add_object_entry ,  which is all
> called way before get_object_details -> check_object -> sha1_object_info .
> Can I safely move the sha1_object_info calll earlier into
> add_object_entry so I will know the size for pruning?

I think so, yes.  And actually this call to sha1_object_info() has been 
bothering me for a while.

There are currently two ways to get the list of objects to pack: one is 
from stdin where objects are listed with their SHA1's, the other one 
uses the internal revision walking code.  In the later case we _already_ 
have the information that sha1_object_info() later provides making it 
rather wasteful by forcing a second object header parsing.

However... aren't you more interested in the _compressed_ blob size than 
its raw size?

> In your other email you mention memory consumption due to object_entry.
> This structure could benefit somewhat from some attention beyond removing
> my no_write.(e.g. int->short for .depth and .delta_limit; int->enum
> for .preferred_base).  Perhaps for later.

Sure.


Nicolas
