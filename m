From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC] Implementing gitweb output caching - issues to solve
Date: Thu, 4 Nov 2010 18:21:51 +0200
Message-ID: <201011041721.53371.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 04 17:22:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE2Zr-0007ar-FW
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 17:22:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987Ab0KDQWI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Nov 2010 12:22:08 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35944 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953Ab0KDQWH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 12:22:07 -0400
Received: by bwz11 with SMTP id 11so1814088bwz.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 09:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=NRzWFmTkGfuNj7qizbmB1x4EQo8Dm5DkFV22jIwLzjk=;
        b=wOf5z5h3KJgUBwK9wQ6DzFcpcMXtl3VzNIBDLyuPSPTFgsyW6E2ASFRO6wuAsKOvtA
         UC8PZYCSkGZVEof0jxTryYyThAKCBtLzlJhE+kujO2+N/CWvXCwN8GDnMvKMmDfvH+rQ
         r48z+odXFHmsXstqTJQDN6ZX322lpbjOeDszg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=LPwlSz03NJAcU5kJyl+5qfmpxPRrvC8NVTpYqsJ8JwVI/1JcxCyWyyMJxt9GOXqtSd
         9K34ckQ+cqE0G4y5zzhnJf4ewnRgzxMdosLUNztdJdnMOHp5h+Zj5Ea884EqIHq5TCxR
         ZH5xh6GxiDu+QxtfRCTwkZd7KYnOznNUeZFUY=
Received: by 10.204.113.74 with SMTP id z10mr832812bkp.25.1288887725369;
        Thu, 04 Nov 2010 09:22:05 -0700 (PDT)
Received: from [192.168.1.13] (abvz101.neoplus.adsl.tpnet.pl [83.8.223.101])
        by mx.google.com with ESMTPS id v25sm109449bkt.6.2010.11.04.09.22.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Nov 2010 09:22:03 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160730>

=46irst, what is the status of gitweb output caching?  I have send mini=
mal
fixup for latest John 'Warthog9' Hawley series as Gitweb caching v7.1[1=
].
John said that he can work on fixes on November 2 at earliest.

[1] http://thread.gmane.org/gmane.comp.version-control.git/160147/focus=
=3D160473


During working on my rewrite of gitweb output caching, based on ideas
(and some code) from John 'Warthog9' Hawley (J.H.) series I have met
with the following issues:

1. Error handling

   There are three separate places where we can encounter error during
   caching.  They are:

    A. setting up cache (initialization)
    B. retrieving data from cache
    C. storing (saving) data in cache.


   There are two possible choices for errors during cache initializatio=
n
   (case A):
     * turn off caching
     * show 500 Internal Server Error

   The problem with turning off caching is that it hides an error, and
   admin can not notice that caching does not work.  Therefore I think
   that better solution would be to generate error, especially that suc=
h
   errors are not, usually, incidental.

   Note that in my opinion cache should not be initialized if caching i=
s
   disabled.
 =20

   The modern CHI caching interface provides a way to change how runtim=
e
   errors are handled via 'on_get_error' and 'on_set_error' parameters =
to
   constructor.  The default for CHI is to log error, or ignore if no
   logger is set.  You can provide a coderef (callback).


   For errors during getting data from cache (case B), we can ignore er=
ror
   which means generating data as if cache was disabled/entry did not
   exist in cache, or erroring out and showing error to user.  Such err=
ors
   should be rare, so erroring out might be appropriate reaction.  Note
   that we have special case of zero sized cache entry file, in which c=
ase
   we treat it as non-existent entry, already.


   For errors during setting (saving) data to cache (case C), we can
   ignore error and not re-generate cache (not even calling callback if
   error is detected early), or error out.  Such errors can happen for
   example if filesystem gets full.  It might be better to ignore such
   errore, at least in the case of ENOSPC / ENOMEM.


2. Progress info and not caching error pages

   J.H. find out or invented very nice hack to generate progress info
   page without Ajax (and therefore without need for JavaScript), to ma=
ke
   user aware that data is being regenerated, and that he/she should be
   patient instead of refreshing or complaining.

   This trick uses the fact that the internal redirect using meta
   refresh[2]

      <meta http-equiv=3D"refresh" content=3D"0" />

   does not occur untill the web browser gets full page (which means th=
at
   connection get closed / end of request).

   [2] http://en.wikipedia.org/wiki/Meta_refresh

   Besides the fact that, as J.H. wrote

    JH> There are still a few known "issues" with respect to this:
    JH> - Code needs to be added to be "browser" aware so
    JH>   that clients like wget that are trying to get a
    JH>   binary blob don't obtain a "Generating..." page

   there is additional problem, at least in my rewrite.  (I didn't foll=
ow
   the code flow in J.H. v7 patch series to check if it also affected).


   Let's assume that 'progress_info' feature is turned on, and that cac=
he
   is generated in background.  Let's assume that error pages (die_erro=
r)
   are not cached.

   Now client tries to access page which would/will result in an error.
   With caching it acquires exclusive (writers) lock, check that there
   are no stale data (error pages are never cached), checks that it is
   provided with 'generating_info' subroutine, so it forks a process to
   generate data in background.

   Background process detaches, tries to generate data to cache,
   die_error is called.  die_error turns off capturing, and prints to
   STDOUT.  At the end of die_error there is jump to outer scope to
   DONE_GITWEB; therefore $lock_fh goes out of scope and lockfile is
   closed, and lock released.  Background process finishes.

   Parent process runs 'generating_info' subroutine.  Now if it waits a
   bit like in my rewrite before employing trick mentioned above, and
   does not print anything if lockfile is released before startup delay=
,
   _and_ die_error finishes within this delay, then everything is all
   right: the error message is sent to client.

   If die_error doesn't finish before git_generating_data_html prints
   meta refresh, or there is no startup delay, then error pages would g=
et
   infinite redirects (remember: there is never anything in cache for
   error pages).  This is a bad thing.


   One possible solution for this problem (beside employing startup
   delay) is to have tee output, i.e. print it as it is being captured.
   Streamed (partial) response would serve as progress indicator for
   process (re)generating cache; only parallel processes waiting for
   cache would show 'generating_info'.

   I think that in current implementation of capturing it would be as
   simple as not closing STDOUT, but I'd have to check that.


3. Using generic cache engine and memory consumption

   Most Perl caching interfaces support only $cache->set($key, $data),
   where $data is a Perl variable, and $data =3D $cache->get($key), or
   their equivalents.  Even for file-based cache drivers you save from
   memory and read into memory. =20

   The only exception I know of is Cache interface with Cache::File
   driver, that provides $cache->handle($key [, $mode]), where optional
   $mode argument can be any of mode strings that can be used in 'open'
   function, or one of fopen(3) modes.  (Of course for memory-based or
   network-based (like memcached) caches it might not make sense to
   provide such interface).

   The most often recommended capture module, Capture::Tiny, allows onl=
y
   capturing into scalar (into memory)=20

     $stdout =3D capture \&code;

   or (using its prototype)
    =20
     $stdout =3D capture { <code> };

   Well, it is *::Tiny, so it supports minimal API.  From the list of
   different capture modules, that allow capturing of Perl code output,
   with different interfaces (API), in "See also" section of
   Capture::Tiny documentation[3], only IO::CaptureOutput allow capturi=
ng
   into specified file:

     capture \&code, \$stdout, undef, $outfile;

   [3] http://p3rl.org/Capture::Tiny


   J.H.'s gitweb output caching v7 captures output directly ito cache
   files.  The problem with doing it in my rewrite is to allow capturin=
g
   directly into cache entry file without losing ability to select
   different caching engine, which might be not file-based (like
   e.g. memcached-based).


P.S. You can always check out my latest work on gitweb output caching
rewrite here (warning: rebased!)

  git://repo.or.cz/git/jnareb-git.git gitweb/cache-kernel-pu

(it is also available in git://github.com/jnareb/git.git)

--=20
Jakub Nar=EAbski
Poland
