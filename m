From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH v2] configure.ac: move the private git m4 macros to a
 dedicated directory
Date: Wed, 11 Sep 2013 22:05:18 +0200
Message-ID: <CA+EOSBkwqBc+1hU_7u0KwoP7EVDszng1c2SKf4xh8YVxG0D3wA@mail.gmail.com>
References: <1378914417-32605-1-git-send-email-gitter.spiros@gmail.com>
	<5230B08D.6080109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 22:05:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJqfI-0000Hw-6x
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 22:05:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757173Ab3IKUFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 16:05:21 -0400
Received: from mail-vc0-f171.google.com ([209.85.220.171]:62303 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754245Ab3IKUFU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 16:05:20 -0400
Received: by mail-vc0-f171.google.com with SMTP id ij15so6578071vcb.16
        for <git@vger.kernel.org>; Wed, 11 Sep 2013 13:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8rDtCkR8MvHnnv9Ujtvz72cdMsq9K8IXGUE6gX0XxxE=;
        b=Q0L7FKNsLGLgTLEowjcqCwrZcomFaXdnugk/fNeWgUBmkr6MpWzb1qEFuscdYBidwQ
         zMEfmLpHanNqxn06QSTN2eUnae5qR8ONG9ahc+snfotB303u0FvaGdX7ZgtlPV2Wzpr3
         fwPIwOKNoZQA/oH/GwvOhMbGvZupsPwFon11hnrmdEyOFIFhP5/h5bwI63/l0Cjh6iUi
         uFT53MTglacV/J7mjJkV0acZBSf16eXl9APT14dv69dnHDlpGKTsOmMEUUDbG5PeWTbs
         iHC6gEdmSTobEIFvqkEjvvrke+yNcjRG5QY2kktHD+z+bgogtddGquOfV8WvtDRXuHOf
         sl4A==
X-Received: by 10.220.144.68 with SMTP id y4mr2136361vcu.28.1378929918829;
 Wed, 11 Sep 2013 13:05:18 -0700 (PDT)
Received: by 10.52.183.38 with HTTP; Wed, 11 Sep 2013 13:05:18 -0700 (PDT)
In-Reply-To: <5230B08D.6080109@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234607>

2013/9/11 Stefano Lattarini <stefano.lattarini@gmail.com>:
> Hi Elia.  Sorry, but I have to give my NAK to this patch.
>
I hold in great consideration the comments of Stephen in this area.
>
> On 09/11/2013 04:46 PM, Elia Pinto wrote:
>>
>> Git use, as many project that use autoconf, private m4 macros.
>>
>> When not using automake, and just relying on autoconf, the macro
>> files are not picked up by default.
>>
>> A possibility, as git do today, is to put the private m4 macro
>> in the configure.ac file, so they will copied over the final configure
>> when calling autoreconf(that call also autoconf).
>> But this makes configure.ac difficult to read and maintain,
>> especially if you want to introduce new macros later. By separating
>> the definitions of the macros from configure.ac file the build system
>> would be more modular.
>>
> In which sense are we being more modular exactly?  After all:
>
>   - the configure.ac of Git is the only user of these macros,
>
>   - using m4_include doesn't offer any performance improvement, and
>
>   - m4 doesn't offer any namespace granularity anyway.
>
> So it seems to me that this patch only adds extra indirections without
> adding any real benefit.

Having a big #include have the same effect di reduced modularization,
larger coupling.

Don't splitting header in include in general is not a good thing. If
you introduce new macros and start using
it in configure.ac in the same commit it becomes more apparent the
significance of their use. less probability of mistake, ecc. But it is
my opinion. Performarce wasn't my goal.
>
>
>> Starting from version 2.58, autoconf provide the macro AC_CONFIG_MACRO_DIR
>> to declare where additional macro files are to be put and found by
>> aclocal.
>> The argument passed to this macro is commonly m4. Despite the
>> documentation,
>> autoconf do nothing with it, only aclocal can use directly if invoked by
>> -I m4 or indirectly using automake. But autoreconf don't invoke aclocal
>> in this way. So in summary you can not use this macro in a useful
>> way if you only use autoconf, as git does.
>>
>> Another historical possibility is to list all your macros in acinclude.m4.
>> This file will be included in aclocal.m4 when you run aclocal, and its
>> macro(s)
>> will henceforth be visible to autoconf. However if it contains numerous
>> macros,
>> it will rapidly become difficult to maintain, and for git this don't
>> provide
>> any benefits or very little.
>>
>> The actual autotool documentation recommend to write each
>> macro in its own file and gather all these files in a separate directory.
>>
> Where exactly id you find that recommendation?  If the autotools docs tell
> to do so *unconditionally*, they are wrong and should be fixed.  In fact,
> even the configure.ac from Automake itself keeps definition of private
> macros in configure.ac...

Maybe I misinterpreted the ufficial documentation (sure it is for
automake ) http://www.gnu.org/software/automake/manual/html_node/Local-Macros.html

And this a good reference for me but it is not ufficial
https://www.flameeyes.eu/autotools-mythbuster/autoconf/macros.html

However, if an automake maintainer can not find the right the patch
certainly has the definitive voice.
>
>> Given the limitations i mentioned earlier, the only possibility is to use
>> the m4_include
>> for including every macro file. The m4_include directive works quite like
>> the
>> #include directive of the C programming language, and simply copies over
>> the content
>> of the file(s).
>>
>> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
>> ---
>> This is a second version of this patch
>> http://article.gmane.org/gmane.comp.version-control.git/231984.
>> The first was plain wrong, my bad. I am sorry for the long delay.
>> Sure it is something low-hanging fruit
>>
>>
>>   configure.ac                      |  148
>> +++----------------------------------
>>   m4/git_arg_set_path.m4            |   14 ++++
>>   m4/git_check_func.m4              |   13 ++++
>>   m4/git_conf_append_path.m4        |   30 ++++++++
>>   m4/git_conf_subst.m4              |   10 +++
>>   m4/git_conf_subst_init.m4         |   15 ++++
>>   m4/git_parse_with.m4              |   22 ++++++
>>   m4/git_parse_with_set_make_var.m4 |   20 +++++
>>   m4/git_stash_flags.m4             |   15 ++++
>>   m4/git_unstash_flags.m4           |   13 ++++
>>   10 files changed, 162 insertions(+), 138 deletions(-)
>>   create mode 100644 m4/git_arg_set_path.m4
>>   create mode 100644 m4/git_check_func.m4
>>   create mode 100644 m4/git_conf_append_path.m4
>>   create mode 100644 m4/git_conf_subst.m4
>>   create mode 100644 m4/git_conf_subst_init.m4
>>   create mode 100644 m4/git_parse_with.m4
>>   create mode 100644 m4/git_parse_with_set_make_var.m4
>>   create mode 100644 m4/git_stash_flags.m4
>>   create mode 100644 m4/git_unstash_flags.m4
>>
>> [SNIP]
>>
>
> Regards,
>   Stefano
