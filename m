From: "George Spelvin" <linux@horizon.com>
Subject: Re: [PATCH 0/7] block-sha1: improved SHA1 hashing
Date: 7 Aug 2009 03:36:01 -0400
Message-ID: <20090807073601.7651.qmail@science.horizon.com>
Cc: art.08.09@gmail.com, git@vger.kernel.org, linux@horizon.com
To: torvalds@linux-foundation.org
X-From: git-owner@vger.kernel.org Fri Aug 07 09:36:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZJzz-0007ZT-9V
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 09:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757083AbZHGHgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 03:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757065AbZHGHgL
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 03:36:11 -0400
Received: from science.horizon.com ([71.41.210.146]:12461 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757077AbZHGHgD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 03:36:03 -0400
Received: (qmail 7652 invoked by uid 1000); 7 Aug 2009 03:36:01 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125187>

> Basically, older P4's will I think shift one bit at a time. So while even 
> Prescott is relatively weak in the shifter department, pre-prescott 
> (Willamette and Northwood) are _really_ weak. If your P4 is one of those, 
> you really shouldn't use it to decide on optimizations.

Thanks for the warning.  The only P4 I have a login on is a Willamette, so
I guess it's a bad optimization target:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 1
model name      : Intel(R) Pentium(R) 4 CPU 1.60GHz
stepping        : 2
cpu MHz         : 1593.888
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pebs bts
bogomips        : 3187.77
clflush size    : 64
power management:



BTW, I'm having a bit of a problem with sha1bench.  Because the number
of rounds is multiplied by 10 until it takes more than mintime, and
the watchdog timer is set to 12*mintime, if I just barely miss the
threshold, I can hit the watchdog on any code that's more than 20% slower
than the reference rfc3174 code:

# /tmp/sha1bench 
#Initializing... Rounds: 10000000, size: 625000K, time: 6.904s, speed: 88.41MB/s
#             TIME[s] SPEED[MB/s]
rfc3174         6.912       88.31
# New hash result: 0489b02aee9fbd82b0bb0cba96f8047e42f543b8
rfc3174         6.911       88.31
linus           3.002       203.3
linusas         3.253       187.7
linusas2        3.059       199.6
mozilla         10.86       56.22
mozillaas       10.33       59.09
openssl         2.145       284.5
spelvin         1.933       315.8
spelvina        1.933       315.8
nettle          2.161       282.4

I had to bump it to 20 times to be able to get past the mozilla code.

You can still have nice round numbers with smaller incements of 2x or 2.5x:

    do {
-      rounds *= 10;
+      rounds *= 2;
+      if (rounds % 9 == 4)
+        rounds += rounds/4;     /* Step 1, 2, 5, 10, 20, 50, 100... */
       uWATCHDOG(mintime*20);
       t1 = GETTIME();
       for (i=0; i<rounds; i++) {
          SHA1Input(sc, arr512b, sizeof(arr512b));
          if (i<64) {
             SHA1Result(sc, arr512b+
                     (i+arr512b[i]+arr512b[arr512b[i]%64]+
                      arr512b[63-i]+arr512b[arr512b[63-i]%64]) %
                     (sizeof(arr512b)-20));
             SHA1Reset(sc);
             }
          }
       t2 = GETTIME(); td = t2-t1;
       }
    while (td<mintime);

And yeah, my P4 is touchy:
n# /var/tmp/sha1bench 
#Initializing... Rounds: 500000, size: 31250K, time: 0.9736s, speed: 31.35MB/s
#             TIME[s] SPEED[MB/s]
rfc3174        0.9931       30.73
# New hash result: 2872616106e163ae9c7c8d12a38bef032323c844
rfc3174        0.9491       32.16
linus          0.4906        62.2
linusas        0.5799       52.62
linusas2       0.4859       62.81
mozilla         1.302       23.44
mozillaas       1.234       24.74
openssl         0.226         135
spelvin        0.2298       132.8
spelvina       0.2494       122.4
nettle         0.3687       82.78
