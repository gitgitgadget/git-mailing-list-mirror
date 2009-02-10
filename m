From: Eric Raible <raible@gmail.com>
Subject: Re: RFH: spawning pager takes long time when when unconnected from 
	network
Date: Tue, 10 Feb 2009 02:53:31 -0800
Message-ID: <279b37b20902100253v3cfd8e45kefa6da7de2ea4a4b@mail.gmail.com>
References: <loom.20090210T015515-886@post.gmane.org>
	 <4991337B.2010102@viscovery.net>
	 <loom.20090210T085859-630@post.gmane.org>
	 <alpine.DEB.1.00.0902101124160.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Eric Raible <raible+git@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 10 11:55:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWqGw-0005Rr-6T
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 11:55:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754574AbZBJKxf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 05:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753520AbZBJKxf
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 05:53:35 -0500
Received: from rv-out-0506.google.com ([209.85.198.227]:11864 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752728AbZBJKxe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 05:53:34 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2248849rvb.1
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 02:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AU4u0er/R3lK6L/b+SO0KHNkJgy2WKpAjjeOf3Zb2I4=;
        b=OcKWeAMIqFJf1CZCmSCl4PJROoIdzTSSHquzZkmZ32uXyC13k4jc6f9cKzmoW5Zp4G
         7QF8dg5JNswB6o1pqatsugnbnIoHLdXLbQq9NaY4MW1YYqzWPo5TirOUUEsouFF8I/dB
         r5gQhy8neCjEnxk5u8ysXFhPVs5RRo+wQhJxA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qsMa7++QRv9UlPo1HcH9vBQJlbATwNgn5pn4ci7vepse19wjmmYoBv9aaKt0/diTKY
         jXyDNff/7D5WbUnJLOOQ3Uu8OGfGstA9tqCIrd5/Fsua1gZoDTY1XI8zREVQM/8awtpI
         CNNkFxsiAHahhizzzNC1gJp7JB3XDppz0Tm5E=
Received: by 10.140.125.1 with SMTP id x1mr2850838rvc.162.1234263211657; Tue, 
	10 Feb 2009 02:53:31 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902101124160.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109199>

On Tue, Feb 10, 2009 at 2:24 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 10 Feb 2009, Eric Raible wrote:
>
>> Johannes Sixt <j.sixt <at> viscovery.net> writes:
>>
>> > Do you have a directory in your PATH that points to a disconnected network
>> > drive? Do you use the default pager settings, or did you customize the pager?
>>
>> All components in my path are local.
>
> Could you run it with GIT_TRACE=<file>?
>
> Ciao,
> Dscho
>

The first thing I tried was to set GIT_TRACE=1, and it doesn't give much:
trace: built-in: git 'diff' 'ss' '--name-only'
trace: run_command: 'sh' '-c' 'less'

The long pause in question begins after the above output is produced
but before the list of files is shown.  The output is identical when setting
GIT_TRACE to a file.

When I pipe the git diff to less or set core.pager="",
then obviously it doesn't call run_command.

Since I can't really reproduce this in the debugger
(because the "bug" is an intermittent delay of 3-10 seconds), I tried
littering the code with trace_printf's.  Didn't really help, partially because
after the dup2 (which is part of spawning the pager process)
they don't on stdout any longer.  Now that I know about setting
GIT_TRACE to a file perhaps this is worth trying again.

But once it started to look like the delay was in the xdiff machinery,
I figured I was chasing a side-effect, and that the real problem was
some interaction between the two processes.  That's when I sent
my first RFH  to the list.

- Eric
