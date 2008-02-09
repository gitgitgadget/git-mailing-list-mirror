From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: [PATCH] opening files in remote.c should ensure it is opening a
 file
Date: Sat, 9 Feb 2008 11:03:41 +0100
Message-ID: <20080209110341.2337a19d@pc09.procura.nl>
References: <20080208174654.2e9e679c@pc09.procura.nl>
	<7vhcgjjjlh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 11:06:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNma4-0005dp-7F
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 11:05:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753873AbYBIKEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 05:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753418AbYBIKEd
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 05:04:33 -0500
Received: from smtp-vbr7.xs4all.nl ([194.109.24.27]:1633 "EHLO
	smtp-vbr7.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753235AbYBIKEc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 05:04:32 -0500
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr7.xs4all.nl (8.13.8/8.13.8) with ESMTP id m19A3giM030137
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 9 Feb 2008 11:03:43 +0100 (CET)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <7vhcgjjjlh.fsf@gitster.siamese.dyndns.org>
X-Mailer: Claws Mail 3.3.0 (GTK+ 2.10.6; x86_64-unknown-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwEAIAAACI8LKTAAAACXBIWXMAAABIAAAASABGyWs+AAAC
 JElEQVRo3u2aMY4CMQxFczZ6RItEzRm4DBINDbRUSPRInIRbsNK6+dJfezN4kokn48IaCSjysL8d
 e9Knoj2fr9f9/gllqQ6U9/vxWK3EdwdIEGjRIVCu18NhuxUfK46SH81+fzrdbuKPx/P5ctHQdAdI
 TKAgpvV6s9ntBEfXEYSGgMQzIHnuFBBjkshCNJ2KtJZ04hHNAugP8bZr3NIHhbcF0AKoK0CoaHXU
 LUWBIs1n+jV+Fl8CVqOApEXAwyMO/DSR4XVntoAYDR7eBjQupuYAYTMph8Rj21D4m7MChN02tpqs
 NSnb/KqU2oHCXu5xDCgflj/RAgBiKBIXnICzAsSjWBsTz5K4/HeXYvb8yK5lY3VGEwPi2aONKT+5
 AlcxrTPOwcTiraGRChgMEKJh0bVVifGVTq6qgBiNVl8QE29EsK6VE+YJAOG2wz5AvsqUS6uqgHCA
 n4NGvBYpnJ64Jgg27sCtxtBk1CJIA4S/GhdWKh07QxUB48jWGhZ4jKamRRr/T8/M0AaEyctry6YB
 4dTGj9iWZNs3DahES5kPCJOu0RQbF/fQOBprsB9gaO9JtPDzII9U5ySXX7AnuIt91y54AAW7rPpT
 LCe5gt3F+CLqr2UarGB3MXvMylWGq4+9RCx3TW1oJq1t3HPQlFs6N1fFNEB4s8dn7Ne7ACSm7TPQ
 I5quAWmw6qBpulHM33B0Csge4Nd8JTTYG2b1XyRe3lH8x34ABJ6aePuQ2N4AAAAASUVORK5CYII=
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73204>

On Fri, 08 Feb 2008 12:09:46 -0800, Junio C Hamano <gitster@pobox.com> wrote:

> "H.Merijn Brand" <h.m.brand@xs4all.nl> writes:
> 
> > HP-UX allows directories to be opened with fopen (path, "r"), which
> > will cause some translations that expect to read files, read dirs
> > instead. This patch makes sure the two fopen () calls in remote.c
> > only open the file if it is a file.
> 
> > +static FILE *open_file(char *full_path)
> > +{
> > +       struct stat st_buf;
> > +       if (stat(full_path, &st_buf) || !S_ISREG(st_buf.st_mode))
> > +               return NULL;
> > +       return (fopen(full_path, "r"));
> > +}
> 
> Can we make this a platform specific "compat" hack?
> 
> It is not fair to force stat() overhead to ports on platforms
> that fails fopen() on directories,

The two I patched were in remote.c and do not happen on every file if I
analyzed it correctly, so overhead would be minimal. However, as I read
the rest of the discussion already, your approach to fix all fopen ()
calls at once seems very reasonable.

Can I get the patch when it is submitted?

> as I doubt we would ever want from directory using fopen() anyway.

I didn't check

-- 
H.Merijn Brand         Amsterdam Perl Mongers (http://amsterdam.pm.org/)
using & porting perl 5.6.2, 5.8.x, 5.10.x  on HP-UX 10.20, 11.00, 11.11,
& 11.23, SuSE 10.1 & 10.2, AIX 5.2, and Cygwin.       http://qa.perl.org
http://mirrors.develooper.com/hpux/            http://www.test-smoke.org
                        http://www.goldmark.org/jeff/stupid-disclaimers/
