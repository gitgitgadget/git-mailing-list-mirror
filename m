From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 0/4] Fix locking issues on Windows with `git clone
 --dissociate`
Date: Mon, 05 Oct 2015 22:29:44 +0200
Organization: gmx
Message-ID: <cover.1444076827.git.johannes.schindelin@gmx.de>
References: <682991036f1e8e974ed8ecd7d20dbcc6fb86c344.1443469464.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Max Kirillov <max@max630.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 22:29:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjCOS-0007YS-3f
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 22:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbbJEU3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 16:29:52 -0400
Received: from mout.gmx.net ([212.227.15.19]:60612 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751300AbbJEU3v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 16:29:51 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M9ra4-1ZuDw11kAC-00B4CK; Mon, 05 Oct 2015 22:29:45
 +0200
In-Reply-To: <682991036f1e8e974ed8ecd7d20dbcc6fb86c344.1443469464.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:tBFVGfj12BWHUFcBOjQH8cuieomgE2Pey7ev0vfaIGusy2MYYkQ
 aclsw366GgVR7Zty7Wuvl3MAiUN+s0VVwRUn9kyixA4+wadC3tt8Tgv2Bk5xUV+DgJLECrE
 4iu4vJAXSUaG8snijJe/zInGyGyTPLEOo5LXksq+rbGqTziFcKYJGQ1T2ti/rYISbJz5c2+
 vTUq3WcvI+Zjuj/NNtY4Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ptj4Xtbt00Q=:OBcFWI98rJid51f9ybu3U9
 WN4A+NytzMjBekwYH36mUzcv/HAzWAS6zMtsHzTTiz7c5GFgwJk6GdXIzTgRRN8Pk0t1TJgB8
 mmyiV6wo1tqgtPlYPJlECd+UXj4KXApA2Hk/DtYg/rBBpKzw+5V7LMxsftJGX33LnJHlWY8LT
 E+0xK770gAtBoFGSMtB5UU9Vt+TLEmzJfItbXSDDyasaGyHlW1Q1cX4xKiGy1zpgjMQA38HrI
 YHbgzp2c+7z5ncZDCS8vKKjW1As6RFIRr46qdCzBslmbYyf7cpUPpKUCQtjgd1MrQ8GEhZ/He
 Dl7MUZvJ55LoBslU47j4Hu5bBJCvG27CDLIA1/MqBiHWROZY8K8Ys2HlMUbrxaC3AXy4BHrq0
 MrnyvtfwFjCkPWSwQRx/lEV2EBP/d2U1JVfJFecf1JXLcZoqz7DEJGp4NQwU7h/pnJqrKGKXu
 /A0drAaHHC+EpJ1bWSgmU9KrnDnt5fjTQxgOzKsrwz2ZreLSJkfD4CY77mazxZoRdhAu18b8J
 cSBLce2CwgQ+pSJFTIyieKVduXeQofXPemWqfF2691ddKiJ/fPIoWTa3LEzRi3+8Z36CHELM4
 DfyvM0lDlBzMS4X/a5qFcmALBzV9me+PRi1xnkbo+Z0+JIk2zCpfWy1Q5YtyZAeejO0PG5N5y
 zyAaP5KjsneHxotPKufjdlwMpxnGNjg61rRE65JjQ0uwdT1JVqKvtv5wLGZ0r4zh/kCtPkHHD
 4Dw4JBz7r+ie1hkF84C1W/Qr+0aJYMQuCQkGnrJzmAItPUJK6DgPiNQIdYKP2q/BnahxAhFd 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279080>

This is version 2, split into multiple commits for easier digestion.

Max, I hope that this helps also your use case!

Johannes Schindelin (4):
  Demonstrate a Windows file locking issue with `git clone --dissociate`
  Consolidate code to close a pack's file descriptor
  Add a function to release all packs
  clone --dissociate: avoid locking pack files

 builtin/clone.c            |  4 +++-
 cache.h                    |  1 +
 sha1_file.c                | 56 ++++++++++++++++++++++++++++------------------
 t/t5700-clone-reference.sh | 21 +++++++++++++++++
 4 files changed, 59 insertions(+), 23 deletions(-)

-- 
2.5.3.windows.1.3.gc322723
