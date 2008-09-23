From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: [PATCH] builtin-prune.c: prune temporary packs in <object_dir>/pack directory
Date: Tue, 23 Sep 2008 06:37:51 +0100
Message-ID: <e1dab3980809222237v612bfc82n8865ada7f0e4516d@mail.gmail.com>
References: <1222104021-28277-1-git-send-email-pasky@suse.cz>
	 <KKSursEoVthEbqc_O82_QIafgU9zgb4bQYP7w6x9ulU85L2Nixe_9g@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Petr Baudis" <pasky@suse.cz>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Brandon Casey" <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Sep 23 07:39:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki0c3-0000V6-EX
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 07:39:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755AbYIWFhx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 01:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751774AbYIWFhx
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 01:37:53 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:33770 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620AbYIWFhw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 01:37:52 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2036265wfd.4
        for <git@vger.kernel.org>; Mon, 22 Sep 2008 22:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=yfz+UjOC+dNXnifwfEXKrmrMwEkNFYDshICttvkWecc=;
        b=lScRwnf5g6AeqVKIWOxPPZMcOOm6lTmtXpRCOLGxtUDD3W8ZvLcLlzplPKQ1z9CaH/
         wXaVOhhTmetHPjdO2qmL/UIM2sEKY6F7usid2PkRprg71FLEVqGveH07XdvpCsd+oyh7
         Lw2BiTiWul72j+VGwnlq+xhKXJzDyS+OKS9cE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=jR4ER7XAn9XDASgipAPNmRNosXI1G7wjLsDSOc+d34AKhsptQ45iJsuNQ+AsYTjwQU
         OcQjpgHQraSPwumMeqaJgUH4z2ZhYTouutc3BQGc8GD5VGzSbfqfbdeeOgi2txjb+rtI
         fa31kjgWJWL6lENLr48HT6geQnRui+d7Zsf+U=
Received: by 10.142.47.6 with SMTP id u6mr1823621wfu.91.1222148271965;
        Mon, 22 Sep 2008 22:37:51 -0700 (PDT)
Received: by 10.142.233.14 with HTTP; Mon, 22 Sep 2008 22:37:51 -0700 (PDT)
In-Reply-To: <KKSursEoVthEbqc_O82_QIafgU9zgb4bQYP7w6x9ulU85L2Nixe_9g@cipher.nrlssc.navy.mil>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96523>

On Tue, Sep 23, 2008 at 12:34 AM, Brandon Casey <casey@nrlssc.navy.mil> wrote:
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
> ---
>
> Re: [PATCH] Do not perform cross-directory renames when creating packs
>
> I think something like this should be applied on top.
>
> -brandon
>
>
>  builtin-prune.c |   18 ++++++++++--------
>  1 files changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/builtin-prune.c b/builtin-prune.c
> index c767a0a..fc8be45 100644
> --- a/builtin-prune.c
> +++ b/builtin-prune.c
> @@ -13,7 +13,7 @@ static const char * const prune_usage[] = {
>  static int show_only;
>  static unsigned long expire;
>
> -static int prune_tmp_object(char *path, const char *filename)
> +static int prune_tmp_object(const char *path, const char *filename)
>  {
>        const char *fullpath = mkpath("%s/%s", path, filename);
>        if (expire) {
> @@ -113,21 +113,19 @@ static void prune_object_dir(const char *path)
>  * files begining with "tmp_") accumulating in the
>  * object directory.
>  */

Good spotting. I haven't been remotely involved with git recently but
for what little it's worth looks the right thing to me. It'd be nice
to modify the patch to keep the comment up to date, something like:

* accumulating in the
* object directory (older git versions) or pack directory.
*/

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"while having code so boring anyone can maintain it, use Python." --
attempted insult seen on slashdot
