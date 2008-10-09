From: "Alexander Gavrilov" <angavrilov@gmail.com>
Subject: Re: [PATCH 5/7] gitk: Make cherry-pick call git-citool on conflicts.
Date: Thu, 9 Oct 2008 12:24:18 +0400
Message-ID: <bb6f213e0810090124i62a51e92n45836ee02577331a@mail.gmail.com>
References: <1223449540-20457-1-git-send-email-angavrilov@gmail.com>
	 <1223449540-20457-2-git-send-email-angavrilov@gmail.com>
	 <1223449540-20457-3-git-send-email-angavrilov@gmail.com>
	 <1223449540-20457-4-git-send-email-angavrilov@gmail.com>
	 <1223449540-20457-5-git-send-email-angavrilov@gmail.com>
	 <1223449540-20457-6-git-send-email-angavrilov@gmail.com>
	 <18669.46569.45285.170033@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Paul Mackerras" <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Oct 09 10:28:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Knqpy-0007lp-3h
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 10:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbYJIIYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 04:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbYJIIYV
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 04:24:21 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:45104 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbYJIIYU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 04:24:20 -0400
Received: by ey-out-2122.google.com with SMTP id 6so1396394eyi.37
        for <git@vger.kernel.org>; Thu, 09 Oct 2008 01:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=d/WVTiuDigi55iOCLs5T+jKbAsfrnB9LhC6fRSerXS0=;
        b=E1EQfjufBObb2yvyNDjQt2jURL720yoHRw1gbjrXxeccSwCP2hfGuvrUAbd7OigpJu
         VpwfHzSB9avDfZ4JE/fihH+edT0i0eil4JxWeLl0tJT08BXwJhKDxznhBI0r3f92+QRs
         WFm5EHG6sW24ZSh2k452DN4DoK8wOHoHWhovY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=EhjNtszV3BfUIUw/TEXYnl2WJtU5ToYa++L8XlIHm4euN4IsvZDN8+xH8/VcZtbewk
         FEtNvyfjBUYRHxiHvjgqZmBNh29lQsFXBi3QyLHX7A9sNK1RiPY9mrnVs6FHf9E3Gl51
         CSH/bYPhJzW6SwFa9td72yBo88g/CLxFCPZcU=
Received: by 10.103.176.20 with SMTP id d20mr5112878mup.136.1223540658069;
        Thu, 09 Oct 2008 01:24:18 -0700 (PDT)
Received: by 10.103.251.10 with HTTP; Thu, 9 Oct 2008 01:24:18 -0700 (PDT)
In-Reply-To: <18669.46569.45285.170033@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97834>

On Thu, Oct 9, 2008 at 11:42 AM, Paul Mackerras <paulus@samba.org> wrote:
>> +proc exec_citool {args {baseid {}}} {
>
> I'm a little nervous about you having a parameter called "args", since
> that specific name has a special meaning in Tcl; it's how Tcl handles
> variable-length argument lists.

Yes, I'd better change that. Probably it works only because that name is
special only as the last parameter.

> If we can assume the existence of a shell (which we do elsewhere), we
> can perhaps do this more simply by putting the environment variable
> settings in the command before the command name.  It's a pity that git
> citool won't take the author name/email/date as command-line arguments
> or from a file, since it ends up being pretty verbose doing it the way
> you have.

If I understand correctly, using a shell would require composing the
command as a string, which itself requires quoting the author name & email,
and other argument strings. I did not feel confident enough to do that, so
chose a dumb but safe solution.

>> @@ -7861,7 +7908,17 @@ proc cherrypick {} {
>>      # no error occurs, and exec takes that as an indication of error...
>>      if {[catch {exec sh -c "git cherry-pick -r $rowmenuid 2>&1"} err]} {
>>       notbusy cherrypick
>> -     error_popup $err
>> +     if {[regexp -line \
>> +         {Entry '(.*)' would be overwritten by merge} $err msg fname]} {
>> +         error_popup [mc "Cherry-pick failed: file '%s' had local modifications.
>> +Your working directory is in an inconsistent state." $fname]
>
> That message seems a bit too scary.  It's not inconsistent, it's just
> got local modifications.  If I remember correctly, in this situation
> git cherry-pick will back out all the changes it did and leave the
> working directory as it was before.

Yes, I'll have to reword it.

> [list] as an idiom for the empty list is a little unusual (here and
> elsewhere in your patches); {} would be more usual.

I'm more used to languages where lists and strings are very different types...
Even in perl you have to use [] for an empty list ref, and '' for an
empty string.

Alexander
