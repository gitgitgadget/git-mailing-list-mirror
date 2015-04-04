From: Oliver Runge <oliver.runge@gmail.com>
Subject: rev-list pretty format behavior
Date: Sun, 5 Apr 2015 01:27:31 +0200
Message-ID: <CAHaCNWJZQRVxp3ponvh3pPEk=sOHGYypyhi1Dc8HX5gkKEBGrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 05 01:27:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeXTg-0006MA-AC
	for gcvg-git-2@plane.gmane.org; Sun, 05 Apr 2015 01:27:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752392AbbDDX1d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2015 19:27:33 -0400
Received: from mail-qc0-f170.google.com ([209.85.216.170]:33999 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752371AbbDDX1c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2015 19:27:32 -0400
Received: by qcyk17 with SMTP id k17so820452qcy.1
        for <git@vger.kernel.org>; Sat, 04 Apr 2015 16:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=d3B8REGeTSi9gNEuuPVFVqSpYSgvriJ06qafEcjlpis=;
        b=0xDf1y13at/YSmm6B2033L6DlbmeJ2fvxvmizKvGK4u9eU55gCQcbUScwg19Zi2KvI
         udXvsyGBNUMpnDXLqET5q8j6m/DgcAXR01jOsXVuiyxdi/1iFoCeqy479ieephrtxWLm
         gaQrnEDWfi7WAUr51IcmusTY2mKlWrZg5TQxiGOZdU0IFxRm6IqNgEpf0oadIku30Typ
         BP0OCkFYaPJP76SnW4nvNc2AOxSMGGGqlj9NkrYAuWLG34mSpfQNWfgb7wFcBwg8jObd
         /K9CiS8JC0TQK9ZprIPJywohL70b1AvkviaY9XpoUDQ76Z2Ua3xGnZvd+tM/fdJCdsTu
         4QOQ==
X-Received: by 10.55.52.67 with SMTP id b64mr16259516qka.47.1428190051890;
 Sat, 04 Apr 2015 16:27:31 -0700 (PDT)
Received: by 10.140.42.47 with HTTP; Sat, 4 Apr 2015 16:27:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266788>

Heyup, everybody.

Apologies if this turns out to be a duplicate. Gmane seems broken, so
I couldn't search the archive.

I'm using git version 2.4.0-rc1. The same behavior exists in 2.1.0.

With git-log it is possible to specify a custom pretty format that
outputs one line per commit:
> git log --pretty=format:"%h ..." HEAD~3...HEAD
826aed5 ...
915e44c ...
067178e ...

Trying the same with rev-list results in:
> git rev-list --pretty=format:"%h ..." HEAD~3...HEAD
commit 826aed50cbb072d8f159e4c8ba0f9bd3df21a234
826aed5 ...
commit 915e44c6357f3bd9d5fa498a201872c4367302d3
915e44c ...
commit 067178ed8a7822e6bc88ad606b707fc33658e6fc
067178e ...

Is the separate line of "commit <hash>" a must for all formats except
"oneline" or a possible bug?
Based on the git-rev-list man page and git-log, I would expect to be
able to override the format as described, since it is possible to get
the "commit <hash>" line for any format by prefixing it with "commit
%H".

The only way to get similar behaviour is to do something like:
> git rev-list ... | grep -v '^commit'
and that's quite hacky.

I looked at the code and the flow in rev-list seems odd to me. The
header_prefix is set outside of show_commit(), it is empty for
format=oneline, but set to "commit " for any other formats. It's then
printed inside show_commit() and followed by the (possibly
abbreviated) hash. So the display logic is split into two places,
neither of which knows much about the other, both make decisions based
on the pretty format specified.

Even if the behavior is correct, would you agree that this could be
refactored a bit, so the output is less stitched together?
I'd happily try to help refactoring or fixing it, if it is indeed a bug.

Thanks for your ears!
  Oliver
