From: "Michael \"Ray\" Rehbein" <mrrehbein@gmail.com>
Subject: Suggestions on how to reorganize and split up a monolithic 
	repository?
Date: Wed, 4 Aug 2010 14:08:23 -0500
Message-ID: <AANLkTikFrj6tyHfmZ8k-gmR+gAFyEGv+X+0x849eEaEP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 04 21:08:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgjKL-0005FG-4j
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 21:08:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933370Ab0HDTI0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Aug 2010 15:08:26 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:35450 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933120Ab0HDTIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Aug 2010 15:08:25 -0400
Received: by vws3 with SMTP id 3so4350461vws.19
        for <git@vger.kernel.org>; Wed, 04 Aug 2010 12:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=iSMu8x1KytHkcWqqRK2T6/RncjXBJTy04b8X3ea5op4=;
        b=SWo/7W88Asm4OabcgWd5uM5UxUKKs1PoOOZfHJA7Ys1hn9VOHxkxphKZ4GSo5vjjUF
         5hPKmM85I+WLLr7SLzRYYP1kVto//ZpDHhjDw1oSQF48kIzn+alEfV+OihfG5l7VctnQ
         2cZvPtsTNeWcv3CIXl6NBMAj1OBAOFrotO69A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=R8Vii+sksJK2tG0o/j/s+zdhy0U9S6H+bE1KxnnNH+qgdO3yQB0beH66tEvKkM4nwD
         ZVVYJTDxQ9zAiU5gSmFr0Po8C0xKOCe0ddh+QokfbYoQ7HXz3nKU6ehIVZiTrwG50RCI
         F8uoGk+Nr2203+iiTKMBs6YM+Mgb0k3hgEjag=
Received: by 10.220.158.9 with SMTP id d9mr6579469vcx.33.1280948904407; Wed, 
	04 Aug 2010 12:08:24 -0700 (PDT)
Received: by 10.220.76.83 with HTTP; Wed, 4 Aug 2010 12:08:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152595>

Currently we have everything in one repository for our website, and
are looking into splitting it up. The scale of one repository looks
like it will be getting out of hand down the road.

General layout at the moment:

repos.git/Site1
repos.git/Site2
repos.git/Library/Ours
repos.git/Library/3rdParty1
repos.git/Library/3rdParty2
repos.git/UnitTests/Ours
repos.git/UnitTests/3rdParty1
repos.git/UnitTests/3rdParty2

Goals in splitting it up:
- Allow each site to have a collection of libraries that are known to
be working for it.  Sometimes an update to shared library to fix site1
will break site2.
- Allow a site to have only the needed libraries, to avoid bloating
the site, and help in identifying unused code.

One plan we started to go with was:

Site1.git/
Site1.git/Library/Ours - submodule link to OurLib.git/Library/Ours
Site1.git/Library/3rdParty1 - submodule link to
3rdParty1Lib.git/Library/3rdParty1

OurLib.git/Library/Ours
OurLib.git/UnitTests/Ours
OurLib.git/Library/3rdParty1 - submodule link to
3rdParty1Lib.git/Library/3rdParty1

3rdParty1Lib.git/Library/3rdParty1
3rdParty1Lib.git/UnitTests/3rdParty1

But found out that git submodule doesn't actually allow mapping a
section of a git repository, so changed it to:

Site1.git/
Site1.git/Library/Ours - symlink to submodule/OurLib/Library/Ours
Site1.git/Library/3rdParty1 - symlink to
submodule/3rdParty1Lib/Library/3rdParty1
Site1.git/submodule/OurLib - submodule OurLib.git
Site1.git/submodule/3rdParty1Lib - submodule 3rdParty1Lib.git

OurLib.git/Library/Ours
OurLib.git/UnitTests/Ours
OurLib.git/Library/3rdParty1 - symlink to
submodule/3rdParty1Lib/Library/3rdParty1
OurLib.git/submodule/3rdParty1Lib - submodule 3rdParty1Lib.git

3rdParty1Lib.git/Library/3rdParty1
3rdParty1Lib.git/UnitTests/3rdParty1

The 3rd Party Lib is not all 3rd party anymore, as we have tweaked it
to fit better in our setup.  Additionally, the 3rd party library
didn't come with unit tests.  One of the unit tests we wrote for our
use of the 3rd party ended up with a use of our library.  Putting a
submodule of OurLib into 3rdParty1Lib would create recursive
submodules, which is not something we want.

Is there a better way to organize this?
