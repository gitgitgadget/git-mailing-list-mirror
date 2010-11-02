From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Support pthread with no recursive mutex (SunOS 5.6)
Date: Tue, 2 Nov 2010 12:35:10 -0500
Message-ID: <20101102173510.GB5636@burratino>
References: <20101102141227.GA3991@thor.il.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
X-From: git-owner@vger.kernel.org Tue Nov 02 18:36:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDKmc-0000xC-6c
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 18:36:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754258Ab0KBRfn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Nov 2010 13:35:43 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53441 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016Ab0KBRfl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Nov 2010 13:35:41 -0400
Received: by fxm16 with SMTP id 16so6026031fxm.19
        for <git@vger.kernel.org>; Tue, 02 Nov 2010 10:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=qp3wP7efOg4po3VrQuicdHIorM4Y/rJzryji8E2Hzug=;
        b=HIWpDdzBKVVqJTTb8ULwIMc12Hgbu0yUe0iVbn5psZW8sSWquKXxEer8Wrr0TjbYmT
         7vYctIWkE12odDPlmOjPdwgb5UcWAQnfPHyZdLft//zxQW3qz7dOpFopbl3VH2cILtwy
         xTOGPqF9QYPVntJ9Dv0qPyruo5xSmuLToCwtk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=YK3m0xasD+fgM2HdIqvLUvehNQ+DBgOdh6WdElYKRJyin/PZDMbZ2EytNBzM9bzl6P
         IkOQAhIN0oqZox04A/hKgTmxeb1I4h279vKYOUi6/HLO8RVOOUJbM9cpqpkQVPiqeuD0
         NRHwvVlGVOXZkt1+4H56PF2ODv6CakTX+dszg=
Received: by 10.223.87.6 with SMTP id u6mr11027109fal.6.1288719340354;
        Tue, 02 Nov 2010 10:35:40 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id j14sm3203418faa.23.2010.11.02.10.35.25
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 02 Nov 2010 10:35:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101102141227.GA3991@thor.il.thewrittenword.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160542>

Hi Gary,

Gary V. Vaughan wrote:

> Thanks for merging my last patch series into the new release.  git 1.7.3.2
> now compiles correctly on all of our hosts, save Solaris 2.6 (SunOS 5.6)
> which has no recursive mutex support in its pthreads.

Nice.

> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1561,7 +1561,11 @@ static pthread_cond_t progress_cond;
>   */
>  static void init_threaded_search(void)
>  {
> +#ifndef NO_RECURSIVE_MUTEX
>  	init_recursive_mutex(&read_mutex);
> +#else
> +	pthread_mutex_init(&read_mutex, NULL);
> +#endif

Wouldn't that defeat the purpose of using a recursive mutex in the first
place?  Let's see...

$ git log -m --first-parent -S'init_recursive_mutex' -- builtin/pack-objects.c
commit ea5f75a64ae52590b06713d45d84de03ca109ccc
Merge: af65543 9374919
Author: Junio C Hamano <gitster@pobox.com>
Date:   Fri May 21 04:02:16 2010 -0700

    Merge branch 'np/malloc-threading'
    
    * np/malloc-threading:
      Thread-safe xmalloc and xrealloc needs a recursive mutex
      Make xmalloc and xrealloc thread-safe
$ git log -S'init_recursive_mutex' af65543..9374919
commit 937491944292fa3303b565b9bd8914c6b644ab13
Author: Johannes Sixt <j6t@kdbg.org>
Date:   Thu Apr 8 09:15:39 2010 +0200

    Thread-safe xmalloc and xrealloc needs a recursive mutex
    
    The mutex used to protect object access (read_mutex) may need to be
    acquired recursively.  Introduce init_recursive_mutex() helper function
    in thread-utils.c that constructs a mutex with the PHREAD_MUTEX_RECURSIVE
    attribute.
    
    pthread_mutex_init() emulation on Win32 is already recursive as it is
    implemented on top of the CRITICAL_SECTION type, which is recursive.
    
        http://msdn.microsoft.com/en-us/library/ms682530%28VS.85%29.aspx
    
    Add do-nothing compatibility wrappers for pthread_mutexattr* functions.
    
    Initial-version-by: Fredrik Kuivinen <frekui@gmail.com>
    Signed-off-by: Johannes Sixt <j6t@kdbg.org>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

Presumably the problem scenarios are something like this:

	ll_find_deltas():
	  init_threaded_search() [sets try_to_free_routine]
	  threaded_find_deltas() ->
	   find_deltas() ->
	    try_delta() [acquires read_lock] ->
	     read_sha1_file() ->
	      read_object() ->
	       xmemdupz() ->
	        xmallocz() ->
	         xmalloc() ->
	          try_to_free_from_threads() ->
	           read_lock() --- deadlock.

Hope that helps,
Jonathan
