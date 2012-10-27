From: Ingo Molnar <mingo@kernel.org>
Subject: 'git describe' is very slow on development trees with lots of commits
Date: Sat, 27 Oct 2012 15:33:52 +0200
Message-ID: <20121027133352.GB30001@gmail.com>
References: <1351261913-28250-1-git-send-email-acme@infradead.org>
 <20121026145451.GA14379@gmail.com>
 <508AA709.7010202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Arnaldo Carvalho de Melo <acme@infradead.org>,
	linux-kernel@vger.kernel.org, Andrew Vagin <avagin@openvz.org>,
	Borislav Petkov <bp@amd64.org>,
	David Howells <dhowells@redhat.com>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Jiri Olsa <jolsa@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Stephane Eranian <eranian@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, arnaldo.melo@gmail.com,
	Arnaldo Carvalho de Melo <acme@redhat.com>
To: David Ahern <dsahern@gmail.com>, git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Sat Oct 27 15:34:17 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1TS6Wm-0001ro-69
	for glk-linux-kernel-3@plane.gmane.org; Sat, 27 Oct 2012 15:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758280Ab2J0Nd7 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sat, 27 Oct 2012 09:33:59 -0400
Received: from mail-ea0-f174.google.com ([209.85.215.174]:39608 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758025Ab2J0Nd5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Oct 2012 09:33:57 -0400
Received: by mail-ea0-f174.google.com with SMTP id c13so1160673eaa.19
        for <multiple recipients>; Sat, 27 Oct 2012 06:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=xa+1fk3TcaCroc1Maf6/csKG8JuonOCjyEcBDxamGBs=;
        b=GzjPUg8D2ynDzJBlQSlpHgQAvgOV7in44bwPaGOSmKAAPHGZFi9S/wu5yVChViAi/a
         g1RKvQyP8nuDXbQzUC9ZWChmorAUT7ebUJAIhsvOzL5gUlN/nV7gept++NqcUYd8xsMs
         f2TClDayWKJlJYWNFexzxpI1acsd8CvySTeXHmNbyAgHP1i+tsTieDmNEBZYY+jmmGTk
         XVjFvxIlCIAGLUckScGHmGC96GSxLHHjx83gni3fwowq6Tkdl4FEQ4qzNaYHY3Czoj3e
         aW5aKevoPiGu+Q6FUXJcKEgHjwl7RHDm4zQeMduH4lvSy/WWtJY6NiMUasVuNKyOaF+w
         R3qw==
Received: by 10.14.214.133 with SMTP id c5mr42434209eep.8.1351344836662;
        Sat, 27 Oct 2012 06:33:56 -0700 (PDT)
Received: from gmail.com (2E6BC28D.catv.pool.telekom.hu. [46.107.194.141])
        by mx.google.com with ESMTPS id g5sm9335831eem.4.2012.10.27.06.33.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 27 Oct 2012 06:33:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <508AA709.7010202@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208509>


(Cc:-ed the Git development list.)

* David Ahern <dsahern@gmail.com> wrote:

> PERF-VERSION-GEN and specifically the git commands are the 
> cause of more delay than the config checks, especially when 
> doing the build in a VM with the kernel source on an NFS 
> mount.

Yes, I have noticed that too.

So, the problem is that we use 'git describe' on the kernel tree 
to generate the version string, which is very, very slow if we 
are far away from any tagged release - which is the case for the 
-tip tree:

 comet:~/tip> perf stat --null --repeat 3 git describe
 v3.7-rc2-2007-g83e8223
 v3.7-rc2-2007-g83e8223
 v3.7-rc2-2007-g83e8223

'git describe' is much faster if we are on or near to a tag:

 $ git checkout v3.6
 $ perf stat --null --repeat 3 git describe
 v3.6
 v3.6
 v3.6

 Performance counter stats for 'git describe' (3 runs):

       0.020171640 seconds time elapsed                                          ( +-  3.64% )

 $ git checkout b34e5f55a1e6

 $ perf stat --null --repeat 3 git describe
 v3.6-41-gb34e5f5
 v3.6-41-gb34e5f5
 v3.6-41-gb34e5f5

 Performance counter stats for 'git describe' (3 runs):

       0.155603676 seconds time elapsed                                          ( +-  0.23% )

The cost on this pretty fast machine is about 1 msecs per commit 
- which adds up to about 2.5 seconds during much of the 
development cycle.

So maybe we should be using a different version string, for 
example, instead of:

 v3.7-rc2-2007-g83e8223

this would be perfectly fine:

 v3.7-rc2-g83e8223

the 'commit count' is informative but not essential - and in 
counting the number of off-tag commits is where much of the 
overhead is:

#
# Overhead  Command       Shared Object                                      Symbol
# ........  .......  ..................  ..........................................
#
    39.79%      git  libz.so.1.2.5       [.] 0x000000000000c1fe                    
    26.39%      git  libz.so.1.2.5       [.] inflate                               
    22.42%      git  git                 [.] 0x000000000009bd1e                    
     2.99%      git  libz.so.1.2.5       [.] adler32                               
     1.23%      git  libc-2.15.so        [.] _int_malloc                           
     0.72%      git  libc-2.15.so        [.] __GI_____strtoull_l_internal          
     0.67%      git  libc-2.15.so        [.] _int_free                             
     0.62%      git  libc-2.15.so        [.] malloc_consolidate                    
     0.54%      git  [kernel.kallsyms]   [k] clear_page_c                          
     0.32%      git  [kernel.kallsyms]   [k] page_fault                            

So by switching to the shorter version string that still embedds 
the tag and the exact sha1 we'd be able to run this script a 
*lot* faster.

Thanks,

	Ingo
