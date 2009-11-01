From: Bernt Hansen <bernt@norang.ca>
Subject: Re: [PATCH 1/2] gitk: Initialize msgcat before first use
Date: Sun, 01 Nov 2009 08:09:01 -0500
Organization: Norang Consulting Inc
Message-ID: <874opel7de.fsf@gollum.intra.norang.ca>
References: <1256415640-10328-1-git-send-email-bernt@norang.ca>
	<1256415640-10328-2-git-send-email-bernt@norang.ca>
	<87d443xn5u.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sun Nov 01 14:12:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4aBH-0007Z2-8X
	for gcvg-git-2@lo.gmane.org; Sun, 01 Nov 2009 14:09:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751956AbZKANJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2009 08:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751952AbZKANJD
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Nov 2009 08:09:03 -0500
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55616 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614AbZKANJC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2009 08:09:02 -0500
Received: from cpe000102d0fe75-cm0012256ecbde.cpe.net.cable.rogers.com ([99.239.148.180] helo=mail.norang.ca)
	by mho-01-ewr.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <bernt@norang.ca>)
	id 1N4aB8-0002c2-Fs; Sun, 01 Nov 2009 13:09:06 +0000
X-Mail-Handler: MailHop Outbound by DynDNS
X-Originating-IP: 99.239.148.180
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1//DBHsLeDQ6eJxugEwC7fd
Received-SPF: none (mail.norang.ca: bernt@gollum.intra.norang.ca does not designate permitted sender hosts) receiver=mail.norang.ca; client-ip=192.168.1.5; helo=gollum.intra.norang.ca; envelope-from=bernt@gollum.intra.norang.ca; x-software=spfmilter 0.97 http://www.acme.com/software/spfmilter/ with libspf-unknown;
Received: from gollum.intra.norang.ca (gollum.intra.norang.ca [192.168.1.5])
	by mail.norang.ca (8.14.3/8.14.3/Debian-5) with ESMTP id nA1D93E5006770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 1 Nov 2009 08:09:04 -0500
Received: from gollum.intra.norang.ca (localhost [127.0.0.1])
	by gollum.intra.norang.ca (8.14.3/8.14.3/Debian-5) with ESMTP id nA1D93vu008100;
	Sun, 1 Nov 2009 08:09:03 -0500
Received: (from bernt@localhost)
	by gollum.intra.norang.ca (8.14.3/8.14.3/Submit) id nA1D926K008099;
	Sun, 1 Nov 2009 08:09:02 -0500
In-Reply-To: <87d443xn5u.fsf@users.sourceforge.net> (Pat Thoyts's message of "31 Oct 2009 21\:34\:53 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131869>

Pat Thoyts <patthoyts@users.sourceforge.net> writes:

> Bernt Hansen <bernt@norang.ca> writes:
>
>>The error text generated when your version of Tcl is too old is
>>translated with msgcat (mc) before msgcat is initialized.  This
>>causes Tcl to abort with:
>>
>>    Error in startup script: invalid command name "mc"
>>
>>We now initialize msgcat first before we check the Tcl version.  Msgcat
>>is available since Tcl 8.1.
>>
>
> This doesn't quite work. [file normalize] was introduced with Tcl 8.4
> and when I test this by starting it using Tcl 8.3 I get an error:
>  "bad option "normalize": must be atime, attributes, channels..."
> from line 11014. It is probably sufficient to just drop the [file
> normalize] here. On Windows $argv0 is fully qualified and 
> [file dirname] works ok on it. By removing the [file normalize] I get
> the expected error dialog when testing with 8.3.
> However, on Windows we actually get a better looking result by not
> catching the [package require Tcl 8.4] and just letting Tk bring up a
> standard message box with the version conflict error message.
>
> Well, actually if show_error just used tk_messageBox it would look
> better on Windows.

You're right.  Thanks for catching this.  When I tested this code I
bumped the version number temporarily to 8.5 instead of downgrading TK
to 8.3.

The problem I was trying to fix was show_error using mc internally
before it was initialized.  Maybe it would be better to give show_error
an optional parameter that controls calling mc - so that the call for
the version check can just bypass the mc translation of the text and OK
buttons.  With this approach the code I moved around can just stay where
it is and all of the existing calls to show_error will use the default
parameter setting which invokes mc.

Would that be a better approach?

-Bernt
