From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 00/30] Read loose references lazily
Date: Thu, 26 Apr 2012 23:33:58 +0200
Message-ID: <4F99BF46.9050501@alum.mit.edu>
References: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu> <xmqqbomfd5bt.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 23:34:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNWKK-0002Ei-Uo
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 23:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758898Ab2DZVeH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 17:34:07 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:44056 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758738Ab2DZVeG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 17:34:06 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q3QLXwpW018370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 26 Apr 2012 23:33:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120410 Thunderbird/11.0.1
In-Reply-To: <xmqqbomfd5bt.fsf@junio.mtv.corp.google.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196417>

On 04/25/2012 08:39 PM, Junio C Hamano wrote:
> mhagger@alum.mit.edu writes:
>
>> From: Michael Haggerty<mhagger@alum.mit.edu>
>>
>> Patches 10 - 25 mostly switch a lot of code from using ref_dir
>> pointers to using ref_entry pointers as arguments and return values.
>> This is important, because ...
>
> The earlier parts looked sane, but the ref_dir set of patches looked
> like merely working around the fact that "struct ref_dir" does not have
> the name field and you had to upcast it to ref_entry to access the full
> name.

Yes, that plus the fact that the ref_entry::flag field is needed in 
ref_entry (to distinguish between value and directory entries) but also 
to interpret the contents of the ref_value / ref_dir.

> All the places that used to take ref_dir never wanted to get an entry
> that represents a leaf node (i.e. ref_value kind of ref_entry), but now
> because you made everybody to take ref_entry, the resulting code is much
> more error prone and the static type checking done by the compiler helps
> us much less when updating the code.  It can already be seen that you
> had to sprinkle a lot of assert(flag&  REF_DIR), but at runtime in
> non-debug build that will become no-op and it is not a substitute for
> the static type checking we used to have.
>
> Can't we approach this differently so that we can keep the type safety?

Thanks for this comment.  I've obviously been ruined by OO languages, in 
which [name + flag + struct ref_value] and [name + flag + struct 
ref_dir] (which *are* useful combinations of data) would be subclasses, 
and the downcasting from ref_entry would only have to occur in only one 
place, while the compiler could guarantee consistency everywhere else.

In C, I don't see a way to implement the equivalent semantics that is 
less annoying than the code that I submitted.

But since [name + flag + struct ref_value] and [name + flag + struct 
ref_dir] never leave the library as structs, it is indeed possible to 
write the code in a different way that leaves most functions working 
with ref_dir instead of having to use ref_entry everywhere.  I have 
implemented this and will submit it shortly.

Thanks again for your suggestion; the resulting code is indeed simpler.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
