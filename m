From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: upload-pack is slow with lots of refs
Date: Wed, 3 Oct 2012 14:36:00 +0200
Message-ID: <CACBZZX70NTic2WtrXooTg+yBbiFFDAEX_Y-b=W=rAkcYKJ3T2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 03 14:36:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJOBx-000729-53
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 14:36:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754698Ab2JCMgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 08:36:23 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:54836 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753898Ab2JCMgW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 08:36:22 -0400
Received: by oagh16 with SMTP id h16so7310097oag.19
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 05:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=HOctR3Op4yHGqejl4YFlcgT17JHhTBUSmTCbmC83hHc=;
        b=bQcboCaXXCs2OtivZhwtEaA4hQqlxW/LzPpJvfoaqS47ttupfFaH+2g6ZJRYZl8MjG
         RDE8byE9GVBLETXsQCCMEkqR5xRnsKp2vmlW8gvVjX93EvcXb++qxT3D62RLOlVACPBF
         1m6u8jGanFIueCwsJAyDl5mO0eOYGF5oCvYnXBv5B7rg7gFPBzZH5vLBXInPtnOmjk6M
         RfhXHck2G4Z3blOn56SAltYkotL5eiVMNzRAPFJjEhSAujQNQIEHEODsPNaKX8cvP0m7
         HB6MCGJvF1J26pKXLsZ8aYBZ8i5p9FmP1PO8tp+wm/dg9RHTybB7KkYXpf6s64/2FoD+
         G8jw==
Received: by 10.60.13.41 with SMTP id e9mr1436772oec.15.1349267781269; Wed, 03
 Oct 2012 05:36:21 -0700 (PDT)
Received: by 10.60.94.225 with HTTP; Wed, 3 Oct 2012 05:36:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206886>

I'm creating a system where a lot of remotes constantly fetch from a
central repository for deployment purposes, but I've noticed that even
with a remote.$name.fetch configuration to only get certain refs a
"git fetch" will still call git-upload pack which will provide a list
of all references.

This is being done against a repository with tens of thousands of refs
(it has a tag for each deployment), so it ends up burning a lot of CPU
time on the uploader/receiver side.

Has there been any work on extending the protocol so that the client
tells the server what refs it's interested in?

I've been looking at turning this into a push mechanism instead of a
poll mechanism, but I've also noted that even when you one tag you
still end up listing all refs on the remote side:

    $ GIT_TRACE=1 git push origin my-new-tag -n
    trace: built-in: git 'push' 'origin' 'my-new-tag' '-n'
    trace: run_command: 'ssh' 'avar@git.example.com' 'git-receive-pack
'\''/gitroot/example.git'\'''
    nohup: redirecting stderr to stdout
    To ssh://avar@git.example.com/gitroot/example.git
     * [new tag]         my-new-tag -> my-new-tag

Which seems like a lot of superfluous work when it presumably only
needs to check if there's a remote "my-new-tag" tag which conflicts
with what you're pushing..
