From: A Large Angry SCM <gitzilla@gmail.com>
Subject: 026fa0d5ad Breaks installs with absolue $(gitexecdir) and $(template_dir)
 variables using older GNU makes
Date: Sun, 01 Feb 2009 13:24:33 -0500
Message-ID: <4985E8E1.90303@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Feb 01 19:30:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTh53-00007X-N5
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 19:30:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752480AbZBASYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 13:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751736AbZBASYh
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 13:24:37 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:10387 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264AbZBASYg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 13:24:36 -0500
Received: by yx-out-2324.google.com with SMTP id 8so432443yxm.1
        for <git@vger.kernel.org>; Sun, 01 Feb 2009 10:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:content-type:content-transfer-encoding;
        bh=NgAlkkk4gR+DTHlHK/QkBcweQb6rO5hg1g+ByHWDaDs=;
        b=Rx2+3WOybiPE+9HthNiFcL01aMFsCSSW3WrYq259bN9XobwDSyErd6CnnKIvy7hx6p
         USoVHwCzJ/r8E3gWTwpPGw8tHYSUF1i57b9yNxt+trUKfgtAhdMC85keAu3+vPBvu3UF
         FKwOVlg9pAuF9oKp8yHmeijHpc19sQZEcNTY0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        b=a26bsjZ6+3T4s/zhEfkzz0Ak2EUDFaSs6UUnYk+AhuJCdzgM2RNoElAuSnauqlAjcT
         wySYFV9poM4asmaklCR10XvYDoPgzTRvGwr/OJ5pKeOBLysANBNZDKODQhlqJfkRMuly
         g+tK3TzB4dnQx5F3DDhLY/ym6rZlRGrDnM8bU=
Received: by 10.100.168.18 with SMTP id q18mr137684ane.7.1233512675633;
        Sun, 01 Feb 2009 10:24:35 -0800 (PST)
Received: from ?10.0.0.6? (c-66-177-19-100.hsd1.fl.comcast.net [66.177.19.100])
        by mx.google.com with ESMTPS id d35sm5693883and.58.2009.02.01.10.24.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 01 Feb 2009 10:24:35 -0800 (PST)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107986>

In 026fa0d5ad9538ca76838070861531c037d7b9ba, "Move computation of 
absolute paths from Makefile to runtime (in preparation for 
RUNTIME_PREFIX)", the following change was made to the Makefile. The 
problem is that $(abspath names...) is a relatively recent addition to 
GNU make and when used in an older GNU make, the test always fails 
resulting incorrect installation dirs for the templates and commands.

The new test is also wrong; (for *nix systems) in that it really wants 
to test if the first character is a '/' but GNU make doesn't have a way 
to do that directly. Instead, it tests if the first character is a / 
_AND_ the path string does not include . or .. components,

The older test has problems itself but at least it allowed you to 
specify absolute paths.

@@ -1407,17 +1417,17 @@ remove-dashes:

  ### Installation rules

-ifeq ($(firstword $(subst /, ,$(template_dir))),..)
-template_instdir = $(bindir)/$(template_dir)
-else
+ifeq ($(abspath $(template_dir)),$(template_dir))
  template_instdir = $(template_dir)
+else
+template_instdir = $(prefix)/$(template_dir)
  endif
  export template_instdir

-ifeq ($(firstword $(subst /, ,$(gitexecdir))),..)
-gitexec_instdir = $(bindir)/$(gitexecdir)
-else
+ifeq ($(abspath $(gitexecdir)),$(gitexecdir))
  gitexec_instdir = $(gitexecdir)
+else
+gitexec_instdir = $(prefix)/$(gitexecdir)
  endif
  gitexec_instdir_SQ = $(subst ','\'',$(gitexec_instdir))
  export gitexec_instdir


I see 3 ways to fix the problem:
	1) go back to using the old test.
	2) keep the new test but add a test that will break the build if
		$(abspath names...) does not work.
	3) something like the following (untested)


  ### Installation rules


  temp = $(subst " ",x,$(template_dir))
  temp = $(subst //,/,$(temp))
  temp = $(addsuffix x,$(temp))
  temp = $(subst /, ,$(temp))
  ifeq ($(strip $(temp)),$(temp))
  template_instdir = $(template_dir)
  else
  template_instdir = $(prefix)/$(template_dir)
  endif
  export template_instdir

  temp = $(subst " ",x,$(gitexecdir))
  temp = $(subst //,/,$(temp))
  temp = $(addsuffix x,$(temp))
  temp = $(subst /, ,$(temp))
  ifeq ($(strip $(temp)),$(temp))
  gitexec_instdir = $(gitexecdir)
  else
  gitexec_instdir = $(prefix)/$(gitexecdir)
  endif
  gitexec_instdir_SQ = $(subst ','\'',$(gitexec_instdir))
  export gitexec_instdir
