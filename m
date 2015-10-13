From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 18/44] refs: move transaction functions into common
 code
Date: Tue, 13 Oct 2015 08:15:57 +0200
Message-ID: <561CA19D.4050404@alum.mit.edu>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com> <1444686725-27660-19-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 13 08:23:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlszL-0002Lc-VH
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 08:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861AbbJMGXD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 02:23:03 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:64097 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751449AbbJMGXC (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Oct 2015 02:23:02 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Oct 2015 02:23:02 EDT
X-AuditID: 12074412-f79a76d000007c8b-77-561ca19f9a03
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id D1.00.31883.F91AC165; Tue, 13 Oct 2015 02:15:59 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB2603.dip0.t-ipconnect.de [93.219.38.3])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t9D6FvG5014112
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 13 Oct 2015 02:15:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1444686725-27660-19-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnleLIzCtJLcpLzFFi42IRYndR1J2/UCbMYHmbpMX8TScYLbqudDM5
	MHkseH6f3ePzJrkApihum6TEkrLgzPQ8fbsE7ox3b5pZC56yV/y9dI2lgXE1WxcjJ4eEgInE
	lqUtrBC2mMSFe+uB4lwcQgKXGSWuTf/JCuGcZZJo//cWrINXQFti5/UdTF2MHBwsAqoS7dck
	QcJsAroSi3qamUBsUYEgiRXLXzBClAtKnJz5hAXEFhFwkLi86ygziC0sEChx/uxDRoj5bYwS
	b28tZAeZySngJXF+kQ5IDbOAnsSO679YIWx5ieats5knMPLPQjJ2FpKyWUjKFjAyr2KUS8wp
	zdXNTczMKU5N1i1OTszLSy3SNdPLzSzRS00p3cQICUihHYzrT8odYhTgYFTi4X0RKRMmxJpY
	VlyZe4hRkoNJSZRXaCJQiC8pP6UyI7E4I76oNCe1+BCjBAezkghvUgtQjjclsbIqtSgfJiXN
	waIkzvtzsbqfkEB6YklqdmpqQWoRTFaGg0NJgrdkAVCjYFFqempFWmZOCUKaiYMTZDiXlEhx
	al5KalFiaUlGPCgi44uBMQmS4gHa+xSknbe4IDEXKArReopRl2PBj9trmYRY8vLzUqXEeStB
	igRAijJK8+BWwNLPK0ZxoI+FeTVBqniAqQtu0iugJUxAS4zYpUCWlCQipKQaGGW6lhelKymf
	/f10fzPnnp8Ob0Srm7oLI3gN3E9xP1EWkPq/7/uVtzNZ6rpcVjb8ULpunV/3KE19Ea/UUbnm
	qKa2T0f6bs6UEBUWv++jJJPjlXtL/9HLxztnKuy6Hae67ITPnE2ngprVy7NaZGb+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279480>

On 10/12/2015 11:51 PM, David Turner wrote:
> The common ref code will build up a ref transaction.  Backends will
> then commit it.  So the transaction creation and update functions should
> be in the common code.  We also need to move the ref structs into
> the common code so that alternate backends can access them.
> 
> Later, we will modify struct ref_update to support alternate backends.

This patch leaks internal implementation details into the public refs
interface. I want to make sure that code elsewhere in Git treats these
structures as opaque. That is why I suggested creating an extra module
to hold "protected" code for the reference backend "class hierarchy" [1].

For a sketch of what my suggestion would look like, see the two commits
at the tip of branch "refs-be-common" on my GitHub repo [2].

Michael

[1] http://article.gmane.org/gmane.comp.version-control.git/279049
[2] https://github.com/mhagger/git

-- 
Michael Haggerty
mhagger@alum.mit.edu
