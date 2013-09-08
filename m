From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 0/3] Unconfuse git clone when two branches at are HEAD.
Date: Sun, 8 Sep 2013 22:00:24 +0100
Organization: OPDS
Message-ID: <5425F66B510F423EA685BCEF40EF8FA7@PhilipOakley>
References: <20130906155204.GE12966@inner.h.apk.li><6649DD0E3B6B4CE59D330217786B6B05@PhilipOakley><xmqqfvthyfui.fsf@gitster.dls.corp.google.com><94A71512041A4F9BB402474DB385E310@PhilipOakley><xmqqwqmsvdfh.fsf@gitster.dls.corp.google.com><531DBE1FF66D4356AEE6AEE5C2FE9389@PhilipOakley> <xmqqk3ir6wu3.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Andreas Krey" <a.krey@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 23:00:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIm5P-0004g9-CY
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 22:59:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326Ab3IHU7z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 16:59:55 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:52725 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751244Ab3IHU7y (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Sep 2013 16:59:54 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AtULAHrkLFJOl3GZ/2dsb2JhbABZgweJcbkbBAQBgSMXdGkBAYEfAQEUAQQBAQUIAQEuHgEBGgcLAgMFAgEDFQELJRQBBBoGBxcGEwgCAQIDAYU4BwGCEiPGBJAAgySBAAOIfYYSmkyDITs
X-IPAS-Result: AtULAHrkLFJOl3GZ/2dsb2JhbABZgweJcbkbBAQBgSMXdGkBAYEfAQEUAQQBAQUIAQEuHgEBGgcLAgMFAgEDFQELJRQBBBoGBxcGEwgCAQIDAYU4BwGCEiPGBJAAgySBAAOIfYYSmkyDITs
X-IronPort-AV: E=Sophos;i="4.90,865,1371078000"; 
   d="scan'208";a="431205487"
Received: from host-78-151-113-153.as13285.net (HELO PhilipOakley) ([78.151.113.153])
  by out1.ip05ir2.opaltelecom.net with SMTP; 08 Sep 2013 21:59:53 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234271>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Sunday, September 08, 2013 6:35 PM
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> What I observed was that all the clones had the same HEAD problem,
>> which I think comes from clone.c: guess_remote_head().
>
> Yes.  They share "having to guess" property because their data
> source does not tell them.
>
>> My quick look at clone.c suggested to me that there would be a lot of
>> commonality between the bundle data stream and the transport streams
>> (identical?), and it was just a case of adding into the bundle data
>> the same HEAD symref indication that would solve the normal clone
>> problem (including backward compatibility). Is that a reasonable
>> assesssment?
>
> You need to find a hole in the existing readers to stick the new
> information in a way that do not break existing readers but allow
> updated readers to extract that information.  That is exactly what
> we did when we added the protocol capability.  I do not offhand
> think an equivalent hole exists in the bundle file format.
> --

I've been rummaging about as to options.

One is to extend the ref format such that
  <sha1> refs/heads/Test:HEAD
would be considered a valid indicator of a symref relationship (i.e. 
using the typical 'colon' style). It would be appended after the regular 
refs, so all the existing refs are still transported.

The point is that while it produces an error, it doesn't stop the 
cloning, and the error message
 "error: * Ignoring funny ref 'refs/remotes/origin/Test:HEAD' locally"
gives a pretty clear statement of intent to those with older versions of 
git.

Another alternative is to add an additional name space (e.g.)
   <sha1> refs/remotes/origin/HEAD/Test
which would simply be an extra directory layer that reflects where the 
HEAD should have been. Though this namespace example has the D/F 
conflict.

Philip
