From: Stefan Zager <szager@google.com>
Subject: static variables
Date: Tue, 10 Dec 2013 17:25:16 -0800
Message-ID: <CAHOQ7J-rO-KjHyYk1Gw6Wv+iH_M7DPr76t3G7YN_sUv3YqcJcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 11 02:25:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqYYF-0005Q4-KZ
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 02:25:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074Ab3LKBZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Dec 2013 20:25:18 -0500
Received: from mail-ob0-f173.google.com ([209.85.214.173]:38282 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429Ab3LKBZR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Dec 2013 20:25:17 -0500
Received: by mail-ob0-f173.google.com with SMTP id gq1so6206019obb.4
        for <git@vger.kernel.org>; Tue, 10 Dec 2013 17:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=2mZUzZEwMK4EkgaEWJzXeuYGxW5HJ1cJ1qlKAddP0MU=;
        b=HHKZ+5/vov1wtbQxT/mJbqrZvQyaLy+CaCQGrpXibgtg9EY5W2HBq6ao3cjiNSPHFO
         tMk8gjuVaCYfmLzZbywi+PPGzkM64CUZq5bZhGaPsTmW7xy0NFjmPwVaJQoFyG58MxZw
         KyeOUWYhHuyRYxb04JTrYvIMLlGoR7p2Ws5aZNQmieCfPcC7ORxo+8YIbsePlNx30alY
         8R0DcDeFPa1ugcKINeaGZUk0Z6P4sXRjRft3T8VTmjQb0AWPkNr2xGOmlDTpxkdQM211
         76BO7ZQg/GymNXW5YMMdEFGRPJa5ecHOHen0oEojsFzRfZK3ApXgSrxUYY+vBm3X2utb
         cwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=2mZUzZEwMK4EkgaEWJzXeuYGxW5HJ1cJ1qlKAddP0MU=;
        b=PyHkZgzc2kDyiQJk/uLEYGHUYSXif7tjqL3rN8FqQajjMIDTgzZpopk4N2UoEUFhJF
         p8Leq88hmTlkMiHAUoXFNHUwOXo/DAj9VCsZmCRGFXPNsHMdsI5KRmoyLMenv3sSpyto
         EFuGIWtDyf8r5d/bmiUnx/uHM8qEMAVNWqW0px5TuypazhUTjMtEM1UpZwDjtwjzbMh/
         H/cib8GTiaBXk7B7GwBI4l6qN0l3sNh2ceskOqNJFgDtd8b45hgmd4gL2YU875cAPJm1
         z7TQlbI+sawQZOQ094wakVAnc0tq/DfsgLcMjece9XJWUNaajTIRxfUtB/snRs5Byndt
         fkng==
X-Gm-Message-State: ALoCoQkiooW4iHL6gDlmWxRvV/ElJpNyliakQf1z6tqysNM/exOAWSncsauCqwax+W9nCNQ3deitu/c4KY6XrW+GttFR4fmtSP96TyXksv0p/4e+r/BIdVhLwEoGFP/hVQx7DNHdHILkLMVkP3Qwyt62aZOKJ3Vyf/bsRQCOo4QgG9nRfo9+XLBhG9JXRihX2V8zjRUs/RXL
X-Received: by 10.60.17.70 with SMTP id m6mr3912452oed.59.1386725116900; Tue,
 10 Dec 2013 17:25:16 -0800 (PST)
Received: by 10.182.233.201 with HTTP; Tue, 10 Dec 2013 17:25:16 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239163>

This is probably a naive question, but: there are quite a lot of static
variables in the git code where it's really unnecessary.  Is that just a
historical artifact, or is there some reason to prefer them?  I'm working
on a patch that will introduce threading, so naturally I'm on the lookout
for static variables.  In general, can I get rid of static variables where
it seems straightforward to do so?

As an example, here's an excerpt from symlnks.c.  In addition to being
static, if I'm reading this right, it appears that the 'removal' variable
is used before it's initialized:

static struct removal_def {
  char path[PATH_MAX];
  int len;
} removal;

static void do_remove_scheduled_dirs(int new_len)
{
  while (removal.len > new_len) {
    removal.path[removal.len] = '\0';
    if (rmdir(removal.path))
      break;
    do {
      removal.len--;
    } while (removal.len > new_len &&
       removal.path[removal.len] != '/');
  }
  removal.len = new_len;
}

void schedule_dir_for_removal(const char *name, int len)
{
  int match_len, last_slash, i, previous_slash;

  match_len = last_slash = i =
    longest_path_match(name, len, removal.path, removal.len,
           &previous_slash);
  /* Find last slash inside 'name' */
  while (i < len) {
    if (name[i] == '/')
      last_slash = i;
    i++;
  }

  /*
   * If we are about to go down the directory tree, we check if
   * we must first go upwards the tree, such that we then can
   * remove possible empty directories as we go upwards.
   */
  if (match_len < last_slash && match_len < removal.len)
    do_remove_scheduled_dirs(match_len);
  /*
   * If we go deeper down the directory tree, we only need to
   * save the new path components as we go down.
   */
  if (match_len < last_slash) {
    memcpy(&removal.path[match_len], &name[match_len],
           last_slash - match_len);
    removal.len = last_slash;
  }
}

void remove_scheduled_dirs(void)
{
  do_remove_scheduled_dirs(0);
}

EOF



Thanks,

Stefan
