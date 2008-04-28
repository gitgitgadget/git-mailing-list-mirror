From: tsgates <tsgatesv@gmail.com>
Subject: Dumb idea on git library for script languages
Date: Mon, 28 Apr 2008 16:03:36 +0900
Message-ID: <1209366216.17090.4.camel@prosumer>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 09:04:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqNPc-0006kv-6j
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 09:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764246AbYD1HDp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 03:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764994AbYD1HDp
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 03:03:45 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:7007 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbYD1HDo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 03:03:44 -0400
Received: by wa-out-1112.google.com with SMTP id m16so7799954waf.23
        for <git@vger.kernel.org>; Mon, 28 Apr 2008 00:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=8X/zzh/jL8nUP9MliEp04/B9W6VBt9AdKwTPn5lbDgQ=;
        b=WVCY0wrzB7tkBhiJ2rQPB0d4eLs5oN5+0rqn8roPyIPiiThRYYFLsuw5IGnrcDennCMoP/pZxcv8DLFMMx8IQrr/GtLuXlZYb1m4ydnPTFFzkhiTZg+OJWWK4FBm4aYwyr1+6ll4s4pUGqT02u9mKWT55F86mYC1M35fh1XDTj8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=aaUsYQQP+g9nneKhlfJb9MRSwbuu8C+bReoe3GWZbSNalsM/r1erzWGBjDjfjpE6LiJtwAm7PShQqiCi/ubAoUH8ur/Fdf2GbazJk/tzzM4Kqhl0DmXh6L5VymMS+kMpYGwS2us7hu7iYb+hJzcJ0qjQ1Tqdbr33tJ7+NprqMsU=
Received: by 10.114.56.1 with SMTP id e1mr6066812waa.52.1209366221011;
        Mon, 28 Apr 2008 00:03:41 -0700 (PDT)
Received: from ?192.168.77.105? ( [125.143.160.43])
        by mx.google.com with ESMTPS id l27sm10562067waf.26.2008.04.28.00.03.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Apr 2008 00:03:40 -0700 (PDT)
X-Mailer: Evolution 2.22.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80505>

Please comment on my naive idea.

When I try to use git in python, there are no fancy ways not to fork any
processes.  (except not active git library) I know it is design policy
of git, one job for one process.

Anyhow, I need to call git in python and perl, so I try to think.

I assumed that 
 1. all cmd_*() is designed in a process basis,
    so it is ok to free all memories which invoked after calling cmd_*()
    
 2. result of cmd_*() is output only
    so parse it in order to use in script language
    right before call cmd_*() -> redirect stdout to anything

 3. 'die()' can be escaped by using "setjmp/longjmp"

 4. actually I need only cmd_*() or little low level functions from
script
 
here is snippets of naive pseudo codes

------------------------------------------------------------
# will be called from the python/perl code
------------------------------------------------------------

lib_git_do() {

  if ( setjmp( exterend here ) ) {
    start_trace()
    cmd_do()
    stop_trace()
  } else {
    # called from die (from longjmp)
    return error occured
  }
  
  return parse_do();
}

------------------------------------------------------------
start_trace() {
  init_mem()
  
  start_malloc_trace()
  start_stdout_trace()
}

stop_trace() {
  stop_stdout_trace()
  stop_malloc_trace()

  clean_mem()
}

start_malloc_trace() {
  hook __malloc_hook
  hook __realloc_hook
  hook __free_hook
}

malloc_hook( size ) {
  void * rtn = malloc( size )
  if ( rtn ) {
     add_to_mem_record( thread_id, rtn )
  }
}

free_hook( ptr ) {
  if ( free( ptr ) ) {
     del_mem_record( thread_id, ptr )
  }
}

clean_mem() {
  for_each ( mem_records ) 
    free( ptr )
}
------------------------------------------------------------

pros
 0. easy to implement
 1. guarantee thread safety
 2. no memory leak
 3. not depend on git source
 4. able to take advantage of script codes, no forking overhead

cons
 0. not fancy
 1. need dumb parsing
 2. just temporary solution

 but, I want to use it in review board or track like system, right now.

If there are any other good suggestions or recommendations on it, please
recommend it.

Best regards
