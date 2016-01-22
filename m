From: Duy Nguyen <pclouds@gmail.com>
Subject: Minor bug, git ls-files -o aborts because of broken submodules
Date: Fri, 22 Jan 2016 16:17:29 +0700
Message-ID: <CACsJy8BpCc6sNKUs3TsMnA_8dk+uFvZy1T_UmfQMxcm2bpg2uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 22 10:18:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMXr6-00041F-9o
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 10:18:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752629AbcAVJSE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 04:18:04 -0500
Received: from mail-lb0-f176.google.com ([209.85.217.176]:32846 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355AbcAVJSA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 04:18:00 -0500
Received: by mail-lb0-f176.google.com with SMTP id x4so38055868lbm.0
        for <git@vger.kernel.org>; Fri, 22 Jan 2016 01:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=gtHYmYDBDeWm11bPSwuKjHuI4sKzQt0CbmDjm7Hq5YY=;
        b=xdZ+9T5icnfNl1vC+xZnpJPKVzr38gDWyIbTy9BY7+aP10Ef7gSEfxa61fhTNVraQX
         n8f/6Z0FYkaxKUjVwgCdu36uyrdUf83HK2OQc1OopdDDV5cszryb7m8/zo57waBhTkOS
         TbfzX8jq7pu7nKB0FSGXa112741zMX/YSl/u0ETe0VpZPe++RPQ14klBNh5uw4amPZuP
         qj5VxLUWnAm+mx3AQW3YPYaguTxEEqYFY5TTvbFHI9SIweu9V7rmuMeqfMK5sbsYmR+Q
         R/b32Yrv8VrRIx2Hj/vK7W2SwPSa+00Pfqyw93Yqijx0meUaZq83om2P6IyHF0AreZRl
         HFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=gtHYmYDBDeWm11bPSwuKjHuI4sKzQt0CbmDjm7Hq5YY=;
        b=eKPvyEjmYI9cSfx5eYkaGPzmFAhACivQbCe2ZLOR5X0wy0nm8ZVFmVirf7Yf5YJj5t
         JHaN5U/ueBZgnQt2inMZMKip4wGlH0DYJiXkhHgMGw+PGnFYTDF+NnTyIQfN/mn2kAOG
         H9KB+taIKz+4hx7gcZalmgMO50ZlfZ+JHjpdfreBegjNNdElMCC7C6oCh0KqZCa7IqLe
         gVjoOR4xk5IN8kKCvvjhTkxcokCVyWIImUX8o7eij5YQPnNDQgigItB/EXwUgCjIxhdT
         EFLmHZPitKRY+UbLU5RgiaynTui6qbhB6S/rSPN1J/vg13iKfNFMdYXHQerjn6zF3C1U
         V2Tg==
X-Gm-Message-State: AG10YOSfaJxbA0gMQ96aW/YNd0pfxud/DtScHhSiBYoUbPXtCIvGIC+QhaQPYHuFrr3dzNycKJqjqW9OH/t+tA==
X-Received: by 10.112.141.97 with SMTP id rn1mr834612lbb.80.1453454279373;
 Fri, 22 Jan 2016 01:17:59 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Fri, 22 Jan 2016 01:17:29 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284554>

$ git init abc
$ cd abc
$ mkdir def
$ echo 'gitdir: blah blah' >def/.git
$ git ls-files -o
fatal: Not a git repository: def/blah blah

If some directory looks like a submodule but turns out not, that's not
a fatal error. The stack trace is something like this. I suspect
do_submodule_path should use the gently version..

#1  0x0000000000588a78 in die
#2  0x0000000000558ded in read_gitfile_gently
#3  0x000000000051e2f6 in do_submodule_path
#4  0x000000000051e484 in git_pathdup_submodule
#5  0x00000000005340ac in resolve_gitlink_ref_recursive
#6  0x00000000005342cf in resolve_gitlink_ref
#7  0x00000000004dd20d in treat_directory
#8  0x00000000004dd760 in treat_one_path
#9  0x00000000004dd971 in treat_path
#10 0x00000000004de038 in read_directory_recursive
-- 
Duy
