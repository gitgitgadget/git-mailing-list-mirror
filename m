From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [GSoC update] git-remote-svn: The final one
Date: Tue, 17 Aug 2010 20:12:18 +0530
Message-ID: <20100817144215.GC24886@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Stefan Sperling <stsp@elego.de>,
	Bert Huijben <rhuijben@collab.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Will Palmer <wmpalmer@gmail.com>,
	Philip Martin <philip.martin@wandisco.com>,
	Jonas Gehring <jonas.gehring@boolsoft.org>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 17 16:44:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlNOv-0002Sn-Qs
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 16:44:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757459Ab0HQOoY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Aug 2010 10:44:24 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:34467 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756017Ab0HQOoX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 10:44:23 -0400
Received: by pzk26 with SMTP id 26so2382137pzk.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 07:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=IFMxg0vQQxgQjiQ3hGbQIxtbfcs3yKTcjcin7inMoK4=;
        b=TZNgZikKktHXBDWlMFwzpUkOIVevZHX49EcGxrggzFDz1SXqk7TT87poQtpssbyNBs
         hWvxIeBEy7F60RmhdEc/btq+hep6JfPdesCV5BfrwXXCiM+tApl3GXrhpEzoxJPVaCJN
         cQf84r1poqI1h6l8abWk/9cCMwoWc9UdtmtHY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=CKZKkFPLbGc8F6RDZLIc+XPqmRH/PYSkB+ZvBvZgUv2TDEmt8wkl53U8S9/uK082Dz
         +cCOwnqPA+VFOo2uu8NCFuqFWGo93NHaNq/UGgSkKvpCkzFCLTkofdMuEImjIVK+1p1H
         8Ao5khtQDfJQCnml8Buf+G+CoQiVBjnC3ywUQ=
Received: by 10.142.48.18 with SMTP id v18mr5878741wfv.100.1282056259493;
        Tue, 17 Aug 2010 07:44:19 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id z1sm9821830wfd.15.2010.08.17.07.44.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 07:44:17 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153750>

Hi,

The GSoC is over. Not that it changes anything; I'm still
here. Anyway, here's a report; this isn't a movie, so don't skip the
credits at the end of the email!

Admittedly, I couldn't deliver everything I'd promised in the
beginning, mainly because I misjudged the size/ difficulty of the
project. While I thought I'd spend most of my time in Git-land
converting and mapping histories, I ended up spending a huge amount of
time with Subversion writing svnrdump. The upside is that we now have
an excellent dumpfile importer/ exporter merged into the Subversion
trunk, while the downside is that we don't have a fully functional
remote helper for Subversion yet. In all, git-remote-svn involved
(involves) the following things:

1. Getting the revision history out of Subversion in a sane format
   (dumpfile v3). This turned out to be MUCH harder than expected;
   fortunately, svnrdump does this better than anything else.
2. Converting the revision history from dumpfile v3 format into a git
   fast-import stream. svn-dump-fast-export does this better than
   anything else. In fact, we've even come up with a proof that
   nothing can even theoretically do better. Unfortunately, it only
   does dumpfile v2 so far, and I still haven't managed to extend it
   to do dumpfile v3.
3. Getting revision history into Subversion. The load functionality in
   svnrdump that I wrote after the mid-term does a good job of this. I
   don't know of any tool that even does something similar.
4. Converting the revision history from a fast-export stream to
   dumpfile v3. I've just started thinking about this, and haven't
   started work on it- it's quite a non-trivial challenge.
5. Stitching everything together with a remote helper
   application. This is much easier than I thought- I wrote a remote
   helper in one afternoon [1], but didn't get it merged because it's
   missing the supporting infrastructure.
6. A branch/tag mapper. I dropped this due to lack of time. It's last
   priority even now, and I'll work on it only when the rest of the
   infrastructure is in place.

I had certain objectives that I'd personally set out to meet in the
beginning of the GSoC. Here they are in brief, and my personal
evaluation of each one. Do feel free to criticize the approach I've
followed and the trade-offs that I've chosen to make.

1. Integration. I was determined to get *everything* merged. I think
   I've been largely successful on this front.
2. Code quality. In terms of bug-fixing and polish, I'm happy with the
   current state of the code, thanks to the sheer number of code
   reviews.
3. Community interaction. I was determined to post atleast once a week
   to the list, keep everyone in the loop, and remain active all the
   time. I think I've done justice to this.
4. Off-topic work. This may sound weird; In addition to my GSoC work, I
   was determined to do some other off-topic work as well to get the
   hang of contributing and participating in wider
   discussions. Although I couldn't pay full attention to this due to
   my heavy workload, I did manage to get some minor OT patches in.
5. Completion. I'm lagging heavily on this front.

On a final note, thanks to everyone for helping! Off the top of my
head, the following people have been especially awesome (in no
particular order). I'm sorry if I've forgotten to include someone (!)

1. Jonathan Nieder - for his painfully detailed reviews, constant
   cleanups and re-rolls.
2. David Barr - for authoring svn-dump-fast-export, without which a
   lot of what we've achieved wouldn't have been possible.
3. Daniel Shahaf - for his endless support while I was writing
   svnrdump. I couldn't have finished it without him.
4. Stefan Sperling - for his detailed review of especially of the
   first iteration of svnrdump, which got things moving in the first
   place.
5. Bert Huijben - for his innumerable contributions and killer
   bugfixes!
6. Sverre Rabbelier - for being an awesome mentor, and being
   supportive throughout.
7. Will Palmer - for writing command-line parsing UI and a test script
   for svnrdump.
8. Sam Vilain - for his writeup on the challenges of mapping in
   Subversion. I realized the challenges involved, and decided not to
   pursue this in the SoC term.
9. Philip Martin - for authoring svnmucc, which served as the
   inspiration for the load functionality in svnrdump.
10. Jonas Gehrig - for authoring rsvndump, which served as the
    inspiration for the dump functionality in svnrdump.
11. =C6var Arnfj=F6r=F0 Bjarmason - for getting me access to a powerful
    server to run lots of validation tests; I ended up fixing many
    bugs that I wouldn't have otherwise been able to do.

Thanks for reading.

[1] http://thread.gmane.org/gmane.comp.version-control.git/147715

-- Ram
