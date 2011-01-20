From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [PATCH 4/5] fast-export: Introduce --inline-blobs
Date: Thu, 20 Jan 2011 08:53:43 -0500
Message-ID: <1295531623.4298.26.camel@drew-northup.unet.maine.edu>
References: <1295415899-1192-1-git-send-email-artagnon@gmail.com>
	 <1295415899-1192-5-git-send-email-artagnon@gmail.com>
	 <7vtyh4smer.fsf@alter.siamese.dyndns.org>
	 <20110119214827.GA31733@burratino>  <20110120045046.GB9493@kytes>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 20 14:54:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfuyM-0002Fk-7f
	for gcvg-git-2@lo.gmane.org; Thu, 20 Jan 2011 14:54:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755575Ab1ATNyk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jan 2011 08:54:40 -0500
Received: from basalt.its.maine.edu ([130.111.32.66]:45920 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752939Ab1ATNyj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jan 2011 08:54:39 -0500
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id p0KDrlIh012916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 20 Jan 2011 08:53:52 -0500
In-Reply-To: <20110120045046.GB9493@kytes>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=6
	Fuz1=6 Fuz2=6
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p0KDrlIh012916
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1296136433.13036@7mOJz2QIXh3mRNlfbKP4oQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165313>


On Thu, 2011-01-20 at 10:20 +0530, Ramkumar Ramachandra wrote:
> Hi,
> 
> Jonathan Nieder writes:
> > Junio C Hamano wrote:
> > > Ramkumar Ramachandra <artagnon@gmail.com> writes:
> > > Just thinking aloud, but is it possible to write a filter that converts an
> > > arbitrary G-F-I stream with referenced blobs into a G-F-I stream without
> > > referenced blobs by inlining all the blobs?
> > 
> > to avoid complexity in the svn fast-import backend itself.
> > (Complicating detail: such a filter would presumably take responsibility
> > for --export-marks, so it might want a way to retrieve commit marks
> > from its downstream.)
> 
> This filter will need to persist every blob for the entire lifetime of
> the program. We can't possibly do it in-memory, so we have to find
> some way to persist them on-disk and retrieve them very
> quickly. Jonathan suggested using something like ToyoCabinet earlier-
> I'll start working and see what I come up with.

Is it worth including the extra dependency? Most systems that I'm in
frequent contact with already have some lightweight BDB implementation
already. I don't currently know of any with TokyoCabinet (or
KyotoCabinet for that matter) already in place. Besides, if all you're
doing is persisting blobs that you're likely to write out to disk
eventually anyway you might as well just do so once you have them and
keep an "index" (not to be confused with the Git Index, just lacking a
better word right now) of what you have in some standard in-memory
format (a heap?). From there you can build each commit into the Git
Index in the proper order once you have the required parts for
each--perhaps even re-using the blobs you've already dumped to disk
(mv'ing them or something).

Granted, there's a good likelihood that I'm missing something here, but
I don't see the point of adding external complexity (beyond what you're
currently stuck dealing with).

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
