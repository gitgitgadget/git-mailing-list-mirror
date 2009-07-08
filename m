From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] quickfetch(): Prevent overflow of the rev-list command line
Date: Wed, 8 Jul 2009 18:01:36 +0200
Message-ID: <200907081801.36901.johan@herland.net>
References: <alpine.DEB.2.00.0906181310400.23400@ds9.cixit.se> <200907081558.51767.johan@herland.net> <4A54B755.4090100@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Peter Krefting <peter@softwolves.pp.se>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jul 08 18:03:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOZbX-00060e-Hk
	for gcvg-git-2@gmane.org; Wed, 08 Jul 2009 18:02:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629AbZGHQC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2009 12:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756740AbZGHQCY
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 12:02:24 -0400
Received: from sam.opera.com ([213.236.208.81]:60408 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756799AbZGHQCX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2009 12:02:23 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id n68G1bbx003546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 8 Jul 2009 16:01:42 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <4A54B755.4090100@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122902>

On Wednesday 08 July 2009, Johannes Sixt wrote:
> Johan Herland schrieb:
> > +	/* If rev-list --stdin encounters an unknown commit, it
> > terminates, +	 * which will cause SIGPIPE in the write loop below.
> > */
>
> Under the conditions you describe here...
>
> > +	signal(SIGPIPE, SIG_IGN);
>
> ... and SIGPIPE being ignored...
>
> > +
> > +	err = start_command(&revlist);
> > +	if (err) {
> > +		error("could not run rev-list");
> > +		return err;
> > +	}
> >
> > -	for (i = 0; argv[i]; i++)
> > -		free(argv[i]);
> > -	free(argv);
> > -	return err;
> > +	for (ref = ref_map; ref; ref = ref->next) {
> > +		if (write_in_full(revlist.in, sha1_to_hex(ref->old_sha1), 40) <
> > 0 || +		    write_in_full(revlist.in, "\n", 1) < 0) {
> > +			error("failed write to rev-list");
> > +			err = errno;
>
> ... don't you get this error message with errno set to EPIPE?
> Previously, there was no error message.

Indeed, you are correct. I guess the following should be added to the
patch:

 	if (write_in_full(revlist.in, sha1_to_hex(ref->old_sha1), 40) < 0 ||
 	    write_in_full(revlist.in, "\n", 1) < 0) {
-		error("failed write to rev-list");
-		err = errno;
+		if (errno != EPIPE) {
+			error("failed write to rev-list");
+			err = errno;
+		}
 		break;
 	}

Maybe I need to do something to the close() call as well? What happens on close() after EPIPE?


Thanks,

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
