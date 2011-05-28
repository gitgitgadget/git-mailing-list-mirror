From: Cesar Eduardo Barros <cesarb@cesarb.net>
Subject: Re: [msysGit] [PATCH] Embed an application manifest on MinGW
Date: Sat, 28 May 2011 18:50:07 -0300
Message-ID: <4DE16E0F.6020807@cesarb.net>
References: <1306612707-29748-1-git-send-email-cesarb@cesarb.net> <alpine.DEB.1.00.1105282241510.11411@bonsai2> <4DE16418.4020002@cesarb.net> <alpine.DEB.1.00.1105282311220.11411@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 28 23:50:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQROn-00068M-MO
	for gcvg-git-2@lo.gmane.org; Sat, 28 May 2011 23:50:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756121Ab1E1VuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 May 2011 17:50:15 -0400
Received: from smtp-04.mandic.com.br ([200.225.81.151]:34759 "EHLO
	smtp-04.mandic.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614Ab1E1VuP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2011 17:50:15 -0400
Received: (qmail 1681 invoked from network); 28 May 2011 21:50:08 -0000
Received: from unknown (HELO cesarb-inspiron.home.cesarb.net) (zcncxNmDysja2tXBptWToZWJlF6Wp6IuYnI=@[200.157.204.20])
          (envelope-sender <cesarb@cesarb.net>)
          by smtp-04.mandic.com.br (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <Johannes.Schindelin@gmx.de>; 28 May 2011 21:50:08 -0000
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Thunderbird/3.1.10
In-Reply-To: <alpine.DEB.1.00.1105282311220.11411@bonsai2>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174680>

Em 28-05-2011 18:19, Johannes Schindelin escreveu:
> On Sat, 28 May 2011, Cesar Eduardo Barros wrote:
>> Em 28-05-2011 17:44, Johannes Schindelin escreveu:
>>> Is it possible that adding the resource object to GITLIBS would reduce
>>> the patch and be "more correct", too?
>>
>> I thought about it, but it felt wrong. It is not a library, it is an
>> object.
>
> Well, a library is a collection of objects. A .a file traditionally
> contains also .o files that define both global and local variables.

It is just a question of names: *LIBS is a list of libraries, *OBJS is a 
list of object files. It feels wrong to add something we call an object 
to something which is a list of things we call libraries. Yes, it is a 
weak argument, but it is the reason it felt wrong to me.

> Even so, let's assume for a moment that you're right and a library is a
> library of functions (which I assume that you assume), and let's ignore
> for a moment that GITLIBS provides non-functions such as inside_git_dir
> and auto_crlf. Then the approach of adding another $(RESOURCE) in exactly
> all the places where we have $(GITLIBS) is so redundant that it asks for
> future inconsistencies (somebody _will_ forget, because things still
> compile). In that case, one patch to rename GITLIBS to, say,
> COMMON_OBJECTS, and another patch to add the manifest to the common
> objects.
>
> But as I said, IMHO GITLIBS is aptly named and should take the resource,
> too.

I see no big problem with it, as long as it does not link the object 
twice. Perhaps creating a new variable which includes both GITLIBS and 
RESOURCE_OBJS but is not included in LIBS (to avoid the double linking)?

>> Also, while adding it to GITLIBS would add the object to all the right
>> rules (in fact, I did a search for GITLIBS to find all the places to add
>> the new object to), I believe it would get the object linked twice in
>> some of the rules (the ones which do a $(filter %.o,$^) would get it
>> both from GITLIBS via the filter and from GITLIBS via $(LIBS) on the
>> command line).
>
> Does it result in a link error? If not, it's not an issue.

It is worse. Not only would it not result in a link error, but it also 
would silently include the manifest resource *twice*. I recall that one 
of the pages I read while researching application manifests said that 
having more than one manifest with the same ID is an error, and we 
cannot know what Windows would do in that case (I would guess either 
"log an error and abort the executable" or "log an error and completely 
ignore the manifest"). And even if it works today, we never know what 
would happen in a future version of Windows.

The resource object really needs to be linked exactly once. It is one of 
those special objects which append or prepend data to fixed sections of 
the executable just by being linked to it (like the crt*.o gcc adds 
internally when linking). With these kinds of objects, even the link 
order is relevant (order is not a problem here because only this object 
adds to the .rsrc section, and the linker puts the section at the 
correct place). In fact, I do not even know if the resource format 
allows one to link more than one resource object in the same executable.

-- 
Cesar Eduardo Barros
cesarb@cesarb.net
cesar.barros@gmail.com
