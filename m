From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 3/9] trailer: read and process config information
Date: Tue, 24 Dec 2013 14:47:41 +0100
Message-ID: <CAP8UFD105z8YrgWPAzsaj7=Zx9x+DqfXBK1FUAmcFYY2rdzvBg@mail.gmail.com>
References: <20131224061541.19560.17773.chriscool@tuxfamily.org>
	<20131224063726.19560.89108.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Dec 24 14:47:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VvSKq-0005u9-6x
	for gcvg-git-2@plane.gmane.org; Tue, 24 Dec 2013 14:47:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752416Ab3LXNrn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Dec 2013 08:47:43 -0500
Received: from mail-ve0-f173.google.com ([209.85.128.173]:54909 "EHLO
	mail-ve0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391Ab3LXNrm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Dec 2013 08:47:42 -0500
Received: by mail-ve0-f173.google.com with SMTP id oz11so3518355veb.18
        for <git@vger.kernel.org>; Tue, 24 Dec 2013 05:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jEPX43ayyM3G3LSX/xkBVN6GzUtst4036Kh7qlZfK3U=;
        b=UA+k0y1XIj7SY1xRiCQd94j9/LjJyMoQgNd2V5RBgDKS5fHzR+hOz3+nhrvaj/I27v
         ypsmmMeEiI67TLuF9oEfQU5AkbvsM5C5Fan4KEu+ntlCS19tel8MdJfsxHbdvUWEF9cB
         xrXAU9T4MNqnGyJozqmBSyRoTE25EgAhXjoGhG29sDL16WvNyXi750zwCeIUfCyUqGZE
         schIQzCvA6x1hH3BS6udCrywBb64clsWC9pNiY7mZY/8b5b2fnnSl6nTSlyTAcbuwB6a
         Vyn93v76YauRlyACWQ5dW3QAlfZIoClllQN3I4N6nakSsTNF0YynXVesht8bY/38Z8tl
         kUOA==
X-Received: by 10.58.46.77 with SMTP id t13mr869322vem.32.1387892861808; Tue,
 24 Dec 2013 05:47:41 -0800 (PST)
Received: by 10.58.253.136 with HTTP; Tue, 24 Dec 2013 05:47:41 -0800 (PST)
In-Reply-To: <20131224063726.19560.89108.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239668>

On Tue, Dec 24, 2013 at 7:37 AM, Christian Couder
<chriscool@tuxfamily.org> wrote:
>
> +static int git_trailer_config(const char *conf_key, const char *value, void *cb)
> +{
> +       if (starts_with(conf_key, "trailer.")) {
> +               const char *orig_conf_key = conf_key;
> +               struct trailer_item *item;
> +               struct conf_info *conf;
> +               char *name;
> +               enum trailer_info_type type;
> +
> +               conf_key += 8;
> +               if (!set_name_and_type(conf_key, ".key", TRAILER_VALUE, &name, &type) &&
> +                   !set_name_and_type(conf_key, ".command", TRAILER_COMMAND, &name, &type) &&
> +                   !set_name_and_type(conf_key, ".where", TRAILER_WHERE, &name, &type) &&
> +                   !set_name_and_type(conf_key, ".ifexist", TRAILER_IF_EXIST, &name, &type) &&
> +                   !set_name_and_type(conf_key, ".ifmissing", TRAILER_IF_MISSING, &name, &type))
> +                       return 0;
> +
> +               item = get_conf_item(name);
> +               conf = item->conf;
> +
> +               if (type == TRAILER_VALUE) {
> +                       if (conf->key)
> +                               warning(_("more than one %s"), orig_conf_key);
> +                       conf->key = xstrdup(value);
> +               } else if (type == TRAILER_COMMAND) {
> +                       if (conf->command)
> +                               warning(_("more than one %s"), orig_conf_key);
> +                       conf->command = xstrdup(value);
> +               } else if (type == TRAILER_WHERE) {
> +                       if (set_where(conf, value))
> +                               warning(_("unknow value '%s' for key '%s'"), value, orig_conf_key);

I realize that I forgot to s/unknow/unknown/.
Sorry about that. It will be in the next version.

> +               } else if (type == TRAILER_IF_EXIST) {
> +                       if (set_if_exist(conf, value))
> +                               warning(_("unknow value '%s' for key '%s'"), value, orig_conf_key);
> +               } else if (type == TRAILER_IF_MISSING) {
> +                       if (set_if_missing(conf, value))
> +                               warning(_("unknow value '%s' for key '%s'"), value, orig_conf_key);
> +               } else {
> +                       die("internal bug in trailer.c");
> +               }
> +       }
> +       return 0;
> +}
