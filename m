From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH] Fix sloppy Getopt::Long.
Date: Tue, 5 May 2009 13:21:16 -0700
Message-ID: <robbat2.20090505T200652.976942941Z@orbis-terrarum.net>
References: <1241547374-6737-1-git-send-email-robbat2@gentoo.org> <7vfxfj1gu9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "Robin H. Johnson" <robbat2@gentoo.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 05 22:21:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1R8s-0003C0-Kp
	for gcvg-git-2@gmane.org; Tue, 05 May 2009 22:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752700AbZEEUVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2009 16:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751913AbZEEUVW
	(ORCPT <rfc822;git-outgoing>); Tue, 5 May 2009 16:21:22 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:33906 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751438AbZEEUVV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 May 2009 16:21:21 -0400
Received: (qmail 2890 invoked from network); 5 May 2009 20:21:19 -0000
Received: from tsi-static.orbis-terrarum.net (HELO curie.orbis-terrarum.net) (76.10.188.108)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Tue, 05 May 2009 20:21:19 +0000
Received: (qmail 21928 invoked by uid 10000); 5 May 2009 13:21:16 -0700
Content-Disposition: inline
In-Reply-To: <7vfxfj1gu9.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118313>

On Tue, May 05, 2009 at 12:37:34PM -0700, Junio C Hamano wrote:
> "Robin H. Johnson" <robbat2@gentoo.org> writes:
> 
> > Getopt-Long v2.38 is much stricter about sloppy getopt usage. The
> > trailing pipe causes git-svn testcases to fail for all of the --stdin
> > argument calls.
> 
> I am not objecting at all; just asking for clarification.
> 
> > -			{ 'stdin|' => \$_stdin, %cmt_opts, %fc_opts, } ],
> > +			{ 'stdin' => \$_stdin, %cmt_opts, %fc_opts, } ],
> 
> Is this "pipe" supposed to be followed by an alternative spelling of the
> option, as in
> 	'stdin|standard-input' => \$_stdin, ...
Yes. Short form or alternative long form.

> and is the sloppyness that it would be crazy to accept either --stdin or
> just -- (without actual option name) for this option?
Within the main loop, both '--' and '-' are treated as special cases
earlier on before the matching of options is done. '--' is the explicit
separator, while '-' is an argument (or a value to an option), not an
option in itself.

> Could an older version of Getopt::Long() have accepted
> 
> 	$ command --foo --bar - other args
> 
> to set $_stdin to true with that "sloppy" syntax?  If so people could have
> relied on such a behaviour, which is a bit worrying.
As far as I can follow in the Getopt::Long code, with the old case of
'stdin|', the empty string case would never have matched anyway.

The v2.38 change in respect to this is not described in the upstream
CHANGES, but boils down to this single modification:

Getopt-Long-2.38/lib/Getopt/Long.pm:
@@ -777,7 +776,7 @@
             # Option name
             (?: \w+[-\w]* )
             # Alias names, or "?"
-            (?: \| (?: \? | \w[-\w]* )? )*
+            (?: \| (?: \? | \w[-\w]* ) )*
           )?

-- 
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85
