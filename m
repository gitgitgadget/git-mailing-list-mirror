From: Laszlo Ersek <lersek@redhat.com>
Subject: Re: [PATCH for-maint] apply: gitdiff_verify_name(): accept "/dev/null\r"
Date: Wed, 24 Sep 2014 14:56:14 +0200
Message-ID: <5422BF6E.60603@redhat.com>
References: <1411434583-27692-1-git-send-email-lersek@redhat.com>	<xmqq1tr2jhg2.fsf@gitster.dls.corp.google.com>	<5421CAA6.3040107@redhat.com>	<xmqqsijihzrb.fsf@gitster.dls.corp.google.com>	<5421D8C4.2080009@redhat.com>	<xmqqfvfihy7i.fsf@gitster.dls.corp.google.com>	<5421DCE3.9090500@redhat.com> <xmqqoau6gguz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jordan.l.justen@intel.com,
	matt.fleming@intel.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 24 14:56:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWm7O-0007E7-MX
	for gcvg-git-2@plane.gmane.org; Wed, 24 Sep 2014 14:56:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654AbaIXM4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2014 08:56:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:18370 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750767AbaIXM4W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2014 08:56:22 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s8OCuJmk022192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Sep 2014 08:56:19 -0400
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-117.ams2.redhat.com [10.36.116.117])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s8OCuFdj003584;
	Wed, 24 Sep 2014 08:56:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <xmqqoau6gguz.fsf@gitster.dls.corp.google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257458>

On 09/23/14 23:35, Junio C Hamano wrote:
> Laszlo Ersek <lersek@redhat.com> writes:
> 
>> [...]

> The important thing to note here is that use of text/plain for
> patches, if you want to have distinction between CRLF and LF in your
> payload, is not designed to work over e-mails.

That's good to know, thanks!

> Now if we accept that this issue is coming from lossy nature of
> transporting patches via e-mails, we would realize that the right
> place to solve this is not in "apply"'s parsing of structural part
> of the "diff" output (e.g. "diff --git ...", "rename from ..." or
> "--- filename"), but the payload part (i.e. " " followed by context,
> "-" followed by removed and "+" followed by added).

I can agree with this, yes.

> Removal of CR
> by "am -> mailsplit -> mailinfo -> apply" callchain is not losing
> any information, as the input does not have useful information to
> let us answer "are the lines in this path supposed to end with
> CRLF?" in the first place; "/dev/null\r" patch is barking up a wrong
> tree.

OK.

> Our line-endings infrastructure (e.g. core.autocrlf configuration
> variable, `eol` attribute) is all geared toward supporting cross
> platform projects in that the BCP is to use LF line endings as the
> canonical line endings for in-repository data and convert it to CRLF
> for working tree files when necessary.  We do not have direct
> support (other than declaring contents for paths as "binary" aka "no
> conversion") to use CRLF in in-repository data (and that is partly
> deliberate).

I see. The edk2 "mirror-of-svn" git repo is then somewhat "incompatible"
with the original design.

> But it is conceivable to enhance the attribute system to allow us to
> mark certain paths (or "all paths", which is a trivial special case)
> as using CRLF line endings in in-repository and in-working-tree.  It
> could be setting `eol` attribute to `both-crlf` or something.
> 
> Then "am -> mailsplit -> mailinfo -> apply" chain could:
> 
>  * "mailsplit" and "mailinfo" does not have to do anything special,
>    other than stripping CR and make sure "apply" only sees LF
>    endings;
> 
>  * "apply" is taught a new option "--fix-mta-corruption" which
>    causes it to pay attention to the `eol` attribute set to
>    `both-crlf`, and when it reads a patch
> 
> 	diff --git a/one b/one
>         --- one
>         +++ one
>         @@ -4,6 +4,6 @@
>          common1
> 	 common2
>         -old1
>         -old2
>         +new1
>         +new2
>          common3
>          common4
> 
>    and notices that path "one" is marked as such, it pretends as if
>    the input were
> 
> 	diff --git a/one b/one
>         --- one
>         +++ one
>         @@ -4,6 +4,6 @@
>          common1^M
> 	 common2^M
>         -old1^M
>         -old2^M
>         +new1^M
>         +new2^M
>          common3^M
>          common4^M
> 
>    to compensate for possible breakage during the mail transit.
> 
>  * "am" is taught to pass "--fix-mta-corruption" to "apply" perhaps
>    by default.
> 
> Because code paths that internally run "git am", e.g. "git rebase",
> work on data that is *not* corrupt by mta (we generate diff and
> apply ourselves), these places need to tell "am" not to use the
> "--fix-mta-corruption" when running "apply".

Thank you for taking the time to describe this. It does look like the
by-the-book solution.

Obviously, I can't implement it myself -- first, I have no experience
with the git codebase, second, I have no time nor mandate to get
familiar with it and to make a serious effort to improve it in this
direction. (IOW "git" is a tool for my job, not my job.) The one-liner
patch and this discussion is all I can manage -- I thought I'd take a
stab at it myself rather than just "complain".

If someone finds the time to implement and document this feature, a
small part of the community will be very grateful. (Not much of a
compensation for a corner case like this, admittedly.)

Thanks,
Laszlo
