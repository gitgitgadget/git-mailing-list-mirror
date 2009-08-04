From: Michael Wild <themiwi@users.sourceforge.net>
Subject: Re: conflict status
Date: Tue, 4 Aug 2009 09:10:00 +0200
Message-ID: <4F52523A-2CEA-4CD3-A094-A2627E2A4403@users.sourceforge.net>
References: <DDAD985F-C9CA-4159-B382-354D4B082C19@users.sourceforge.net> <fabb9a1e0908031037t16a828f6h4de9fb11bcc957fe@mail.gmail.com> <200908032017.35101.trast@student.ethz.ch> <7vvdl4925k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>,
	Sverre Rabbelier <srabbelier@gmail.com>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 09:10:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYEAF-0006q9-Dx
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 09:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbZHDHKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 03:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbZHDHKM
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 03:10:12 -0400
Received: from mxout002.mail.hostpoint.ch ([217.26.49.181]:52715 "EHLO
	mxout002.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932503AbZHDHKE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Aug 2009 03:10:04 -0400
Received: from [10.0.2.20] (helo=asmtp002.mail.hostpoint.ch)
	by mxout002.mail.hostpoint.ch with esmtp (Exim 4.69 (FreeBSD))
	(envelope-from <themiwi@users.sourceforge.net>)
	id 1MYE9r-0009z5-Fd; Tue, 04 Aug 2009 09:10:03 +0200
Received: from [82.130.106.80] (helo=nynaeve.ifd.mavt.ethz.ch)
	by asmtp002.mail.hostpoint.ch with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69 (FreeBSD))
	(envelope-from <themiwi@users.sourceforge.net>)
	id 1MYE9r-000FOi-8a; Tue, 04 Aug 2009 09:10:03 +0200
X-Authenticated-Sender-Id: mi@miba.li
In-Reply-To: <7vvdl4925k.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124762>


On 3. Aug, 2009, at 20:35, Junio C Hamano wrote:

> Thomas Rast <trast@student.ethz.ch> writes:
>
>> That only shows 'unmerged: foo' for me...
>>
>> The closest to porcelain I can get while still having all the
>> information is
>>
>>  $ git ls-files -s foo
>>  100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 1       foo
>>  100644 d00491fd7e5bb6fa28c517a0bb32b8b506539d4d 2       foo
>>
>> In other words, not porcelain at all.
>
> "git ls-files -u" would be what you want.  It shows all the paths with
> conflicts in the index, and omits paths without conflicts in the  
> index.
> And the object names allow you to inspect the individual stages.
>


I found out about that one too (by having a look at git-mergetool),  
and came up with the following quick hack (doesn't take any arguments/ 
options, is very rough and slow for a large number of conflicts). For  
each unmerged file it displays the file name, prefixed with the local  
and remote state. Possible states are "c" for created, "m" for  
modified and "d" for deleted. Probably there are other cases I'm not  
aware of and require special handling.

#!/bin/sh
# displays the merge status of files

# TODO all the niceties, bells and whistles...
USAGE=''
# requires PWD to be top-level
unset SUBDIRECTORY_OK
  . "$(git --exec-path)/git-sh-setup"
# obviously...
require_work_tree

# describe the state (deleted, modified or created)
describe_state () {
   mode="$1"

   if test -z "$mode"; then
     printf "d "
   else
     if test -n "$base_mode"; then
       printf "m "
     else
       printf "c "
     fi
   fi
}

# get all conflicts
conflicts="$(git-status | awk '/unmerged:/{print $3;next}')"

for f in $conflicts; do
   # extract the file mode for base, local and remote
   base_mode=$(git ls-files -u -- "$f" | awk '{if ($3==1) print $1;}')
   local_mode=$(git ls-files -u -- "$f" | awk '{if ($3==2) print $1;}')
   remote_mode=$(git ls-files -u -- "$f" | awk '{if ($3==3) print $1;}')
   # create the status flags
   describe_state "$local_mode"
   describe_state "$remote_mode"
   # append the file name
   echo " $f"
done
